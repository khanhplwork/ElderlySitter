import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:elscus/core/models/cus_models/cus_detail_model.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/model/data_search_model.dart';
import 'package:elscus/process/event/cus_event.dart';
import 'package:elscus/process/state/cus_state.dart';
import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../../core/utils/globals.dart' as globals;
import '../../core/utils/math_lib.dart';
import '../../core/validators/validations.dart';
import '../../presentation/success_screen/success_screen.dart';
import '../../presentation/widget/dialog/fail_dialog.dart';

class CusBloc {
  final eventController = StreamController<CusEvent>();

  final stateController = StreamController<CusState>();

  String? fullname;
  String? phone;
  String? address;
  String? gender;
  String? dob;
  String? avatarImgUrl;
  String? backCardImgUrl;
  String? frontCardImgUrl;
  String? description;
  String? idNumber;
  String? email;
  String? password;
  String? rePassword;
  bool isCommit = false;
  DataSearchModel? modelSearch;
  double lat = 0;
  double lng = 0;
  String district = "";
  final Map<String, String> errors = HashMap();

  CusBloc() {
    eventController.stream.listen((event) {
      if (event is FillFullnameCusEvent) {
        fullname = event.fullname;
        errors.remove("fullname");
      }
      if (event is FillPhoneNumberCusEvent) {
        phone = event.phoneNumber;
        errors.remove("phoneNumber");
      }
      if (event is FillIDNumberCusEvent) {
        idNumber = event.idNumber;
        errors.remove("idNumber");
      }
      if (event is FillEmailCusEvent) {
        email = event.email;
        errors.remove("email");
      }
      if (event is FillPasswordCusEvent) {
        password = event.password;
        errors.remove("password");
      }
      if (event is FillRePasswordCusEvent) {
        rePassword = event.rePassword;
        errors.remove("rePassword");
      }
      if (event is ChooseGenderCusEvent) {
        gender = event.gender;
        errors.remove("gender");
      }
      if (event is ChooseDobCusEvent) {
        dob = event.dob;
        stateController
            .add(CusDobState(dobController: TextEditingController(text: dob)));
        errors.remove("dob");
      }
      if (event is FillAddressCusEvent) {
        address = event.address;
        errors.remove("address");
        stateController.sink.add(UpdateAddressState());
      }
      if (event is GetInfoCusEvent) {
        getCusByID();
      }
      if (event is UpdateInfoCusEvent) {
        if (cusValidate()) {
          updateCus(event.context);
        }else{
          print('sai nè');
        }
      }
      if (event is SignUpCusEvent) {
        if (cusSignUpValidate()) {
          signUpCus(event.context);
        }
      }
      if (event is ChooseAvaImageCusEvent) {
        avatarImgUrl = event.avaUrl;
      }
      if (event is InitCusDataCusEvent) {
        initCusData();
      }
      if (event is TickIsCommitEvent) {
        isCommit = true;
        stateController.sink.add(TickIsCommitState(isCommit: isCommit));
      }
    });
  }

  bool cusValidate() {
    bool isValid = false;
    bool isValidFullname = false;
    bool isValidPhoneNumber = false;
    bool isValidIDNumber = false;
    bool isValidGender = false;
    bool isValidDOB = false;
    bool isValidAddress = false;
    if (fullname == null || fullname!.trim().isEmpty) {
      errors.addAll({"fullname": "Vui lòng điền tên"});
    } else {
      errors.remove("fullname");
      isValidFullname = true;
    }

    if (phone == null || !Validations.isValidPhoneNumber(phone!.trim())) {
      errors.addAll({"phoneNumber": "Số điện thoại phải có 10 chữ số"});
    } else {
      errors.remove("phoneNumber");
      isValidPhoneNumber = true;
    }

    if (idNumber == null || !Validations.isValidIDNumber(idNumber!.trim())) {
      errors.addAll({"idNumber": "CMND/CCCD phải có 9 hoặc 12 chữ số"});
    } else {
      errors.remove("idNumber");
      isValidIDNumber = true;
    }

    if (gender == null || gender!.trim().isEmpty) {
      errors.addAll({"gender": "Vui lòng chọn giới tính"});
    } else {
      errors.remove("gender");
      isValidGender = true;
    }

    if (dob == null || dob!.trim().isEmpty) {
      errors.addAll({"dob": "Vui lòng nhập ngày sinh"});
    } else {
      if (Validations.isValidCustomerAge(dob)) {
        errors.remove("dob");
        isValidDOB = true;
      } else {
        errors.addAll({"dob": "Tuổi của người dùng phải >=18"});
      }
    }
    if (address == null || address!.trim().isEmpty) {
      errors.addAll({"address": "Vui lòng điền địa chỉ"});

    } else {
      errors.remove("address");
      isValidAddress = true;
    }

    if (isValidFullname &&
        isValidPhoneNumber &&
        isValidIDNumber &&
        isValidGender &&
        isValidDOB &&
        isValidAddress) {
      stateController.sink.add(CusOtherState());
      isValid = true;
    } else {
      stateController.sink.addError(errors);
    }

    return isValid;
  }

  bool cusSignUpValidate() {
    bool isValid = false;
    bool isValidFullname = false;
    bool isValidEmail = false;
    bool isValidPhoneNumber = false;
    bool isValidPassword = false;
    bool isValidRePassword = false;

    if (fullname == null || fullname!.trim().isEmpty) {
      errors.addAll({"fullname": "Vui lòng điền tên"});
    } else {
      errors.remove("fullname");
      isValidFullname = true;
    }

    if (email == null || email!.trim().isEmpty) {
      errors.addAll({"email": "Vui lòng điền email"});
    } else {
      if (Validations.isValidEmail(email!)) {
        errors.remove("email");
        isValidEmail = true;
      } else {
        errors.addAll({"email": "Vui lòng nhập đúng email"});
      }
    }
    if (password == null || password!.trim().isEmpty) {
      errors.addAll({"password": "Vui lòng điền mật khẩu"});
    } else {
      if (Validations.isValidPassword(password!)) {
        errors.remove("password");
        isValidPassword = true;
      } else {
        errors.addAll({
          "password":
              "Mật khẩu phải có tối thiểu 8 ký tự Bao gồm chữ In chữ thường và số"
        });
      }
    }
    if (rePassword == null || rePassword!.trim().isEmpty) {
      errors.addAll({"rePassword": "Vui lòng nhập lại mật khẩu"});
    } else {
      if (password == rePassword) {
        errors.remove("rePassword");
        isValidRePassword = true;
      } else {
        errors.addAll({"rePassword": "Mật khẩu không trùng khớp"});
      }
    }
    if (phone == null || !Validations.isValidPhoneNumber(phone!.trim())) {
      errors.addAll({"phoneNumber": "Số điện thoại phải có 10 chữ số"});
    } else {
      errors.remove("phoneNumber");
      isValidPhoneNumber = true;
    }
    if(isCommit){
      errors.remove("commit");

    }else{
      errors.addAll({"commit": "Vui lòng đọc và xác nhận điều khoản của chúng tôi"});
    }

    if (isValidFullname &&
        isValidPhoneNumber &&
        isValidEmail &&
        isValidPassword &&
        isValidRePassword && isCommit) {
      stateController.sink.add(CusOtherState());
      isValid = true;
    } else {
      stateController.sink.addError(errors);
    }

    return isValid;
  }

  Future<void> updateCus(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/customer/mobile/update");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "id": globals.customerID,
            "fullName": fullname,
            "phone": phone,
            "address": address,
            "gender": gender,
            "dob": MathLib().convertInputElderDob(dob!),
            "avatarImgUrl": (avatarImgUrl != null) ? avatarImgUrl : "",
            "backCardImgUrl": "",
            "frontCardImgUrl": "",
            "description": "Chú Thích",
            "idCardNumber": idNumber,
            "latitude": "$lat",
            "longitude": "$lng",
            "district": district,
          },
        ),
      );
      print('Test status code updateCus :${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        initCusData();
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SuccessScreen(
                  content: "Thay đổi thông tin người dùng thành công",
                  buttonName: "Trang tài khoản",
                  navigatorPath: '/accountScreen'),
            ));
      } else {
        // ignore: use_build_context_synchronously
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> getCusByID() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/customer/common/customer/${globals.customerID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      log("getCusByID + ${response.body}");
      if (response.statusCode.toString() == '200') {
        CusDetailModel rs = CusDetailModel.fromJson(json.decode(response.body));
        district=rs.data.zone;
        log(district);
        stateController.sink.add(CusDetailState(
            cusInfo: rs.data));
      } else {
        throw Exception('Unable to fetch cus from the REST API');
      }
    } finally {}
  }

  Future<void> initCusData() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/customer/common/customer/${globals.customerID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      print('Test initCusData code: ${response.statusCode}');
      print('Test initCusDate msg: ${response.body}');
      if (response.statusCode.toString() == '200') {
        globals.cusDetailModel =
            CusDetailModel.fromJson(json.decode(response.body)).data;
      } else {
        throw Exception('Unable to fetch cus from the REST API');
      }
    } finally {}
  }

  Future<void> signUpCus(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/customer/mobile/register");

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "name": fullname!,
            "phone": phone!,
            "email": email!,
            "password": password!
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        initCusData();
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SuccessScreen(
                  content: "Đăng ký tài khoản thành công",
                  buttonName: "Trở về trang đăng nhập",
                  navigatorPath: "/loginWithGoogleNav"),
            ));
      } else {
        // ignore: use_build_context_synchronously
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }
}
