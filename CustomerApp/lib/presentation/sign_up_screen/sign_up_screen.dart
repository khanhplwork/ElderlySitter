import 'package:elscus/presentation/sign_up_screen/term_commitments_screen.dart';
import 'package:elscus/process/event/cus_event.dart';
import 'package:elscus/process/state/cus_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_constant.dart';
import '../../core/constants/image_constant.dart';
import '../../process/bloc/cus_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _cusBloc = CusBloc();
  bool _showPass = false;
  bool _isCommit = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return StreamBuilder<CusState>(
        stream: _cusBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is TickIsCommitState) {
              _isCommit = (snapshot.data as TickIsCommitState).isCommit;
            }
          }
          return Material(
            child: Container(
              width: size.width,
              height: size.height,
              padding: EdgeInsets.only(
                left: size.width * 0.07,
                right: size.width * 0.07,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageConstant.imgLoginBg),
                  fit: BoxFit.fill,
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Text(
                      'Đăng ký',
                      style: GoogleFonts.roboto(
                        fontSize: size.height * 0.042,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.06,
                      ),
                      child: Theme(
                        data: theme.copyWith(
                          colorScheme: theme.colorScheme
                              .copyWith(primary: ColorConstant.primaryColor),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            _cusBloc.eventController.sink.add(
                                FillFullnameCusEvent(
                                    fullname: value.toString()));
                          },
                          style: TextStyle(
                              fontSize: size.width * 0.04, color: Colors.black),
                          cursorColor: ColorConstant.primaryColor,
                          controller: null,
                          decoration: InputDecoration(
                            hintText: "Họ và tên",
                            errorText: (snapshot.hasError &&
                                    (snapshot.error as Map<String, String>)
                                        .containsKey("fullname"))
                                ? (snapshot.error
                                    as Map<String, String>)["fullname"]
                                : null,
                            prefixIcon: SizedBox(
                              width: size.width * 0.05,
                              child: Icon(
                                Icons.account_circle_sharp,
                                size: size.width * 0.05,
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                      ),
                      child: Theme(
                        data: theme.copyWith(
                          colorScheme: theme.colorScheme
                              .copyWith(primary: ColorConstant.primaryColor),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            _cusBloc.eventController.sink.add(
                                FillEmailCusEvent(email: value.toString()));
                          },
                          style: TextStyle(
                              fontSize: size.width * 0.04, color: Colors.black),
                          cursorColor: ColorConstant.primaryColor,
                          controller: null,
                          decoration: InputDecoration(
                            hintText: "Email",
                            errorText: (snapshot.hasError &&
                                    (snapshot.error as Map<String, String>)
                                        .containsKey("email"))
                                ? (snapshot.error
                                    as Map<String, String>)["email"]
                                : null,
                            prefixIcon: SizedBox(
                              width: size.width * 0.05,
                              child: Icon(
                                Icons.mail,
                                size: size.width * 0.05,
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                      ),
                      child: Theme(
                        data: theme.copyWith(
                          colorScheme: theme.colorScheme
                              .copyWith(primary: ColorConstant.primaryColor),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            _cusBloc.eventController.sink.add(
                                FillPhoneNumberCusEvent(
                                    phoneNumber: value.toString()));
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontSize: size.width * 0.04, color: Colors.black),
                          cursorColor: ColorConstant.primaryColor,
                          controller: null,
                          decoration: InputDecoration(
                            hintText: "Số điện thoại",
                            errorText: (snapshot.hasError &&
                                    (snapshot.error as Map<String, String>)
                                        .containsKey("phoneNumber"))
                                ? (snapshot.error
                                    as Map<String, String>)["phoneNumber"]
                                : null,
                            prefixIcon: SizedBox(
                              width: size.width * 0.05,
                              child: Icon(
                                Icons.phone,
                                size: size.width * 0.05,
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Theme(
                            data: theme.copyWith(
                              colorScheme: theme.colorScheme.copyWith(
                                  primary: ColorConstant.primaryColor),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                _cusBloc.eventController.sink.add(
                                    FillPasswordCusEvent(
                                        password: value.toString()));
                              },
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                color: Colors.black,
                              ),
                              obscureText: !_showPass,
                              cursorColor: ColorConstant.primaryColor,
                              controller: null,
                              decoration: InputDecoration(
                                errorText: (snapshot.hasError &&
                                        (snapshot.error as Map<String, String>)
                                            .containsKey("password"))
                                    ? (snapshot.error
                                        as Map<String, String>)["password"]
                                    : null,
                                hintText: "Mật Khẩu",
                                prefixIcon: SizedBox(
                                  width: size.width * 0.05,
                                  child: Icon(
                                    Icons.lock,
                                    size: size.width * 0.05,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCED0D2), width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: ColorConstant.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: size.height * 0.02),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  onToggleShowPass();
                                });
                              },
                              child: Icon(
                                _showPass
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye_outlined,
                                color: _showPass
                                    ? ColorConstant.primaryColor
                                    : Colors.grey,
                                size: size.height * 0.028,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Theme(
                            data: theme.copyWith(
                              colorScheme: theme.colorScheme.copyWith(
                                  primary: ColorConstant.primaryColor),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                _cusBloc.eventController.sink.add(
                                    FillRePasswordCusEvent(
                                        rePassword: value.toString()));
                              },
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                color: Colors.black,
                              ),
                              obscureText: !_showPass,
                              cursorColor: ColorConstant.primaryColor,
                              controller: null,
                              decoration: InputDecoration(
                                errorText: (snapshot.hasError &&
                                        (snapshot.error as Map<String, String>)
                                            .containsKey("rePassword"))
                                    ? (snapshot.error
                                        as Map<String, String>)["rePassword"]
                                    : null,
                                hintText: "Nhập lại mật khẩu",
                                prefixIcon: SizedBox(
                                  width: size.width * 0.05,
                                  child: Icon(
                                    Icons.lock,
                                    size: size.width * 0.05,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCED0D2), width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: ColorConstant.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: size.height * 0.02),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  onToggleShowPass();
                                });
                              },
                              child: Icon(
                                _showPass
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye_outlined,
                                color: _showPass
                                    ? ColorConstant.primaryColor
                                    : Colors.grey,
                                size: size.height * 0.028,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.02,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(
                                  (states) => ColorConstant.primaryColor),
                              focusColor: ColorConstant.primaryColor,
                              value: _isCommit,
                              onChanged: (bool? value) {
                                setState(() {});
                              },
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TermAndCommitmentsScreen(
                                              cusBloc: _cusBloc),
                                    ));
                              },
                              child: Text(
                                "Điều khoản & Cam kết",
                                style: GoogleFonts.roboto(
                                  decoration: TextDecoration.underline,
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    (snapshot.hasError &&
                            (snapshot.error as Map<String, String>)
                                .containsKey("commit"))
                        ? SizedBox(
                            width: size.width,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: size.width * 0.03,
                              ),
                              child: Text(
                                (snapshot.error as Map<String, String>)["commit"]!,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ColorConstant.redErrorText,
                                  fontSize: size.height * 0.016,
                                  height: 0.01,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: size.height * 0.055,
                        child: ElevatedButton(
                          onPressed: () {
                            _cusBloc.eventController.sink
                                .add(SignUpCusEvent(context: context));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.primaryColor,
                            textStyle: TextStyle(
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          child: const Text("Đăng ký"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              color: ColorConstant.grey500,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.05,
                                right: size.width * 0.05),
                            child: Text(
                              "Hoặc ",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: ColorConstant.grey600,
                                fontSize: size.height * 0.018,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              color: ColorConstant.grey500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                      ),
                      child: Container(
                        width: size.width,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            textStyle: TextStyle(
                              fontSize: size.width * 0.045,
                            ),
                            elevation: 5,
                            shadowColor: Colors.grey,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(ImageConstant.imgGoogle,
                                  width: size.height * 0.04),
                              Text(
                                '    Đăng ký với Google',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            // setState(() {
                            //   final provider = Provider.of<GoogleSignInProvider>(
                            //       context,
                            //       listen: false);
                            //   provider.googleLogin();
                            // });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                      ),
                      child: SizedBox(
                        width: size.width,
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Đã có tài khoản? ',
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.018,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Đăng nhập',
                                  style: GoogleFonts.roboto(
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
