// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:elscus/core/validators/validations.dart';
import 'package:elscus/presentation/success_screen/success_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:elscus/presentation/widget/dialog/fail_dialog.dart';
import 'package:elscus/process/event/authen_event.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../core/utils/globals.dart' as globals;
import '../../fire_base/provider/google_sign_in_provider.dart';
import '../../presentation/forgot_password_screen/forgot_password_add_new_password.dart';
import '../../presentation/forgot_password_screen/forgot_password_confirm_passcode.dart';
import '../state/authen_state.dart';

class AuthenBloc {
  //get request
  final eventController = StreamController<AuthenEvent>();

  //response
  final stateController = StreamController<AuthenState>();

  final Map<String, String> errors = HashMap();
  String? username;
  String? password;
  String? phoneNumber;
  String? rePassword;
  String? oldPassword;

  AuthenBloc() {
    eventController.stream.listen((AuthenEvent event) {
      if (event is LoginEvent) {
        if (loginValidate()) {
          loginWithAccount(event.context);
        } else {}
      } else if (event is InputUsernameEvent) {
        username = event.username;
      } else if (event is InputPasswordEvent) {
        password = event.password;
      } else if (event is MaintainLoginEvent) {
        final elsBox = Hive.box('elsBox');
        username = elsBox.get('email');
        password = elsBox.get('password');
        loginWithAccount(event.context);
      } else if (event is LogoutEvent) {
        logout(event.context);
      } else if (event is LoginWithGoogle) {
        loginWithGoogle(event.context, event.email, event.fullName, event.dob,
            event.gender, event.token);
      } else if (event is InputPhoneNumberAuthenEvent) {
        phoneNumber = event.phoneNumber;
      } else if (event is SendPhoneNumberForgotAuthenEvent) {
        if (phoneNumber != null) {
          stateController.sink.add(AuthenState());
          if (Validations.isValidPhoneNumber(phoneNumber)) {
            sendPhoneForgot(event.context);
          } else {
            stateController.sink.addError("Số điện thoại chỉ bao gồm 10 ký tự");
          }
        } else {
          stateController.sink.addError("Vui lòng nhập số điện thoại");
        }
      } else if (event is SendOtpCodeForgotAuthenEvent) {
        if (event.otpCode.isNotEmpty) {
          if (event.otpCode.length == 4) {
            stateController.sink.add(AuthenState());
            sendOtpCodeForgot(event.context, event.otpCode, event.phoneNumber);
          } else {
            stateController.sink.addError("Mã OTP phải gồm 4 chữ số");
          }
        } else {
          stateController.sink.addError("Vui lòng mã otp");
        }
      } else if (event is InputRePasswordEvent) {
        rePassword = event.rePassword;
      } else if (event is InputOldPasswordEvent) {
        oldPassword = event.oldPassword;
      } else if (event is SendNewPassForgotAuthenEvent) {
        if (password != null && rePassword != null) {
          if (password == rePassword) {
            if (Validations.isValidPassword(password!) &&
                Validations.isValidPassword(password!)) {
              stateController.sink.add(AuthenState());
              sendNewPassForgot(event.context, password!, event.phoneNumber);
            } else {
              stateController.sink.addError(
                  "Mật khẩu phải có tối thiểu 8 ký tự bao gồm chữ thường chữ viết hoa và số");
            }
          } else {
            stateController.sink.addError("Mật khẩu không trùng khớp");
          }
        } else {
          stateController.sink
              .addError("Vui lòng nhập đầy đủ mật khẩu và nhập lại mật khẩu");
        }
      } else if (event is ChangePasswordAuthenEvent) {
        if (changePasswordValidate()) {
          changePassword(event.context);
        } else {}
      } else {
        if (kDebugMode) {
          print('AuthenBloc do nothing');
        }
      }
    });
  }

  bool changePasswordValidate() {
    bool isValid = false;
    bool isValidOldPassword = false;
    bool isValidNewPassword = false;
    bool isValidRePassword = false;
    if (oldPassword != null && oldPassword!.isNotEmpty) {
      if (Validations.isValidPassword(oldPassword!)) {
        errors.remove("oldPassword");
        isValidOldPassword = true;
      } else {
        errors.addAll({
          "oldPassword":
              "Mật khẩu phải có tối thiểu 8 ký tự bao gồm chữ thường chữ in hoa và số"
        });
      }
    } else {
      errors.addAll({"oldPassword": "Vui lòng nhập mật khẩu hiện tại"});
    }
    if (password != null && password!.isNotEmpty) {
      if (Validations.isValidPassword(password!)) {
        errors.remove("newPassword");
        isValidNewPassword = true;
      } else {
        errors.addAll({
          "newPassword":
              "Mật khẩu phải có tối thiểu 8 ký tự bao gồm chữ thường chữ in hoa và số"
        });
      }
    } else {
      errors.addAll({"newPassword": "Vui lòng nhập mật khẩu mới"});
    }
    if (rePassword != null && rePassword!.isNotEmpty) {
      if (rePassword == password) {
        errors.remove("rePassword");
        isValidRePassword = true;
      } else {
        errors.addAll({"rePassword": "Mật khẩu không trùng khớp"});
      }
    } else {
      errors.addAll({"rePassword": "Vui lòng nhập lại mật khẩu"});
    }
    stateController.sink.addError(errors);
    if (isValidOldPassword && isValidNewPassword && isValidRePassword) {
      isValid = true;
      stateController.sink.add(AuthenState());
    }
    return isValid;
  }

  bool loginValidate() {
    bool isValid = false;
    bool isValidUsername = false;
    bool isValidPassword = false;
    if (username == null || username!.trim().isEmpty) {
      errors.addAll({"username": "Vui lòng nhập tài khoản"});
    } else {
      if (Validations.isValidEmail(username!)) {
        errors.remove("username");
        isValidUsername = true;
      } else {
        errors.addAll({"username": "Vui lòng nhập đúng định dạng email"});
      }
    }
    if (password == null || password!.trim().isEmpty) {
      errors.addAll({"password": "Vui lòng nhập mật khẩu"});
    } else {
      if (Validations.isValidPassword(password!)) {
        errors.remove("password");
        isValidPassword = true;
      } else {
        errors.addAll({
          "password":
              "Mật khẩu phải có tối thiểu 8 ký tự bao gồm Chữ cái Thường, Chữ cái in hoa và ký tự khác"
        });
      }
    }
    if (isValidUsername && isValidPassword) {
      isValid = true;
      stateController.sink.add(AuthenState());
    } else {
      stateController.sink.addError(errors);
    }
    return isValid;
  }

  Future<void> changePassword(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/common/auth/change-password");
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "email": globals.cusDetailModel!.email,
            "oldPassword": oldPassword!,
            "newPassword": password!,
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SuccessScreen(
                    content: "Thay đổi mật khẩu thành công",
                    buttonName: "Trở về trang tài khoản",
                    navigatorPath: "/accountScreen")));
        final elsBox = Hive.box('elsBox');
        elsBox.put('password', password);
      } else {
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> sendPhoneForgot(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/common/auth/send-otp");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "phone": phoneNumber!,
            'deviceId': globals.deviceID,
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForgotPasswordConfirmPasscodeScreen(
                  phoneNumber: phoneNumber!),
            ));
      } else {
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> sendOtpCodeForgot(
      BuildContext context, String otp, String phoneNumber) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/common/auth/check-otp");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "phone": phoneNumber,
            "otp": otp,
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ForgotPasswordAddNewPasswordScreen(phoneNumber: phoneNumber),
            ));
      } else {
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> sendNewPassForgot(
      BuildContext context, String newPass, String phoneNumber) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/common/auth/forgot-password");
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "phone": phoneNumber,
            "newPassword": newPass,
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        Navigator.pushNamed(context, '/loginWithGoogleNav');
      } else {
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> loginWithAccount(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/common/auth/login");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'email': username!,
            'password': password!,
            'token': globals.deviceID,
          },
        ),
      );

      if (response.statusCode.toString() == '200') {
        globals.bearerToken =
            json.decode(response.body)["data"]["token"].toString();
        if (Jwt.parseJwt(globals.bearerToken.split(" ")[1])["authorities"][0]
                    ["authority"]
                .toString() ==
            "CUSTOMER") {
          if (Jwt.parseJwt(globals.bearerToken.split(" ")[1])["status"]
                  .toString() ==
              "ACTIVATE") {
            globals.customerID =
                Jwt.parseJwt(globals.bearerToken.split(" ")[1])["id"]
                    .toString();

            final elsBox = Hive.box('elsBox');
            elsBox.put('checkLogin', true);
            elsBox.put('email', username!);
            elsBox.put('password', password);
            Navigator.pushNamed(context, '/homeScreen');
          } else {
            showFailDialog(context, "Đăng nhập không thành công");
          }
        } else {
          showFailDialog(
              context, "Tài khoản đã được đăng ký dưới vai trò khác");
        }
      } else {
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> loginWithGoogle(BuildContext context, String email,
      String fullName, String dob, String gender, String token) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/common/auth/login-customer-gmail");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "email": email,
            "fullName": fullName,
            "dob": dob,
            "gender": gender,
            "token": token
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        globals.bearerToken =
            json.decode(response.body)["data"]["token"].toString();
        if (Jwt.parseJwt(globals.bearerToken.split(" ")[1])["authorities"][0]
                    ["authority"]
                .toString() ==
            "CUSTOMER") {
          if (Jwt.parseJwt(globals.bearerToken.split(" ")[1])["status"]
                  .toString() ==
              "ACTIVATE") {
            globals.customerID =
                Jwt.parseJwt(globals.bearerToken.split(" ")[1])["id"]
                    .toString();
            Navigator.pushNamed(context, '/homeScreen');
          } else {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.logout();
            logout(context);
            showFailDialog(context, "Đăng nhập không thành công");
          }
        } else {
          showFailDialog(
              context, "Tài khoản đã được đăng ký dưới vai trò khác");
        }
      } else {
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }



  Future<void> logout(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/common/auth/logout/${globals.cusDetailModel!.email}");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{},
        ),
      );
      if (response.statusCode.toString() == '200') {
        Navigator.pushNamed(context, '/loginWithGoogleNav');
      } else {
        if (kDebugMode) {
          print('Đăng xuất thất bại');
        }
      }
    } finally {}
  }
}
