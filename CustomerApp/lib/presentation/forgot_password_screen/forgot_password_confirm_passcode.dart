import 'package:elscus/presentation/forgot_password_screen/forgot_password_add_new_password.dart';
import 'package:elscus/process/bloc/authen_bloc.dart';
import 'package:elscus/process/event/authen_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_constant.dart';
import '../../core/constants/image_constant.dart';

// ignore: must_be_immutable
class ForgotPasswordConfirmPasscodeScreen extends StatefulWidget {
  ForgotPasswordConfirmPasscodeScreen({Key? key, required this.phoneNumber})
      : super(key: key);
  String phoneNumber;

  @override
  State<ForgotPasswordConfirmPasscodeScreen> createState() =>
      // ignore: no_logic_in_create_state
      _ForgotPasswordConfirmPasscodeScreenState(phoneNumber: phoneNumber);
}

class _ForgotPasswordConfirmPasscodeScreenState
    extends State<ForgotPasswordConfirmPasscodeScreen> {
  _ForgotPasswordConfirmPasscodeScreenState({required this.phoneNumber});

  String phoneNumber;
  String passcode = "";
  final _authenBloc = AuthenBloc();
  final codeChar1Controller = TextEditingController();
  final codeChar2Controller = TextEditingController();
  final codeChar3Controller = TextEditingController();
  final codeChar4Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return StreamBuilder<Object>(
        stream: _authenBloc.stateController.stream,
        builder: (context, snapshot) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                bottomOpacity: 0.0,
                elevation: 0.0,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: size.height * 0.03,
                    color: Colors.black,
                  ),
                ),
              ),
              body: Container(
                height: size.height,
                width: size.width,
                padding: EdgeInsets.only(
                  left: size.width * 0.07,
                  right: size.width * 0.07,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.imgConfirmedamico,
                        width: size.width,
                        height: size.height * 0.3,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.03,
                        ),
                        child: Text(
                          'Mã xác thực đã được gửi đến email',
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: size.height * 0.02,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.1,
                        ),
                        child: Theme(
                            data: theme.copyWith(
                              colorScheme: theme.colorScheme.copyWith(
                                  primary: ColorConstant.primaryColor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: size.height * 0.075,
                                  child: TextField(
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: Colors.black),
                                    cursorColor: ColorConstant.primaryColor,
                                    controller: codeChar1Controller,
                                    textAlign: TextAlign.center,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffCED0D2), width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: ColorConstant.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                SizedBox(
                                  width: size.height * 0.075,
                                  child: TextField(
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: Colors.black),
                                    cursorColor: ColorConstant.primaryColor,
                                    textInputAction: TextInputAction.next,
                                    textAlign: TextAlign.center,
                                    controller: codeChar2Controller,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffCED0D2), width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: ColorConstant.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                SizedBox(
                                  width: size.height * 0.075,
                                  child: TextField(
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: Colors.black),
                                    cursorColor: ColorConstant.primaryColor,
                                    textInputAction: TextInputAction.next,
                                    textAlign: TextAlign.center,
                                    controller: codeChar3Controller,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffCED0D2), width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: ColorConstant.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                SizedBox(
                                  width: size.height * 0.075,
                                  child: TextField(
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: Colors.black),
                                    cursorColor: ColorConstant.primaryColor,
                                    textAlign: TextAlign.center,
                                    controller: codeChar4Controller,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffCED0D2), width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: ColorConstant.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      (snapshot.hasError)
                          ? Text(
                              snapshot.error.toString(),
                              style: GoogleFonts.roboto(
                                color: ColorConstant.redErrorText,
                                fontSize: size.height * 0.022,
                              ),
                            )
                          : const SizedBox(),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.1,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: size.height * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                String otpCode =
                                    "${codeChar1Controller.text}${codeChar2Controller.text}${codeChar3Controller.text}${codeChar4Controller.text}";
                                _authenBloc.eventController.sink.add(
                                    SendOtpCodeForgotAuthenEvent(
                                        context: context,
                                        otpCode: otpCode,
                                        phoneNumber: phoneNumber));
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.primaryColor,
                              textStyle: TextStyle(
                                fontSize: size.width * 0.045,
                              ),
                            ),
                            child: const Text("Tiếp tục"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
