import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/presentation/forgot_password_screen/forgot_password_confirm_passcode.dart';
import 'package:elscus/process/bloc/authen_bloc.dart';
import 'package:elscus/process/event/authen_event.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_constant.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _authenbloc = AuthenBloc();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return StreamBuilder<Object>(
      stream: _authenbloc.stateController.stream,
      builder: (context, snapshot) {
        return Material(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              bottomOpacity: 0.0,
              elevation: 0.0,
              leading: GestureDetector(
                onTap: (){
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
                left: size.width*0.07,
                right: size.width*0.07,
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
                      ImageConstant.imgForgotpasswordamico,
                      width: size.width,
                      height: size.height * 0.3,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height*0.03,
                      ),
                      child: Text(
                        'Vui lòng nhập email đã đăng ký',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height*0.022,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height*0.03,
                      ),
                      child: Text(
                        'Mã xác thực sẽ được gửi đến email này',
                        style: GoogleFonts.roboto(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w400,
                          fontSize: size.height*0.02,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                      ),
                      child: Theme(
                        data: theme.copyWith(
                          colorScheme: theme.colorScheme
                              .copyWith(primary: ColorConstant.primaryColor),
                        ),
                        child: TextField(
                          style: TextStyle(
                              fontSize: size.width * 0.04, color: Colors.black),
                          cursorColor: ColorConstant.primaryColor,
                          controller: null,
                          keyboardType: TextInputType.number,
                          onChanged: (value){
                            _authenbloc.eventController.sink.add(InputPhoneNumberAuthenEvent(phoneNumber: value.toString()));
                          },
                          decoration: InputDecoration(
                            hintText: "Email",
                            errorText:
                            snapshot.hasError ? snapshot.error.toString() : null,
                            prefixIcon: SizedBox(
                              width: size.width * 0.05,
                              child: Icon(
                                Icons.email,
                                size: size.width * 0.05,
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xffCED0D2), width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(6))),
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
                        top: size.height * 0.1,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: size.height * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            _authenbloc.eventController.sink.add(SendPhoneNumberForgotAuthenEvent(context: context));
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
      }
    );
  }
}
