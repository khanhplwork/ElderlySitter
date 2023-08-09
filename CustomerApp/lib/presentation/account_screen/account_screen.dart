import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/utils/globals.dart' as globals;
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/presentation/history_screen/history_screen.dart';
import 'package:elscus/presentation/history_second_screen/history_second_screen.dart';
import 'package:elscus/presentation/personal_screen/personal_detail_screen.dart';
import 'package:elscus/presentation/test_deep_link_screen/test_deep_link_screen.dart';
import 'package:elscus/process/event/authen_event.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../fire_base/provider/google_sign_in_provider.dart';
import '../../process/bloc/authen_bloc.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _elsBox = Hive.box('elsBox');
  final _authenBloc = AuthenBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return Material(
      child: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
          left: size.width * 0.03,
          right: size.width * 0.03,
        ),
        decoration: BoxDecoration(
          color: ColorConstant.greyAccBg,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.05,
                ),
                child: Text(
                  'Tài khoản',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: size.height * 0.03,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonalDetailScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.02,
                  ),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.15,
                    padding: EdgeInsets.all(size.width * 0.03),
                    decoration: BoxDecoration(
                      color: ColorConstant.primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 4.0,
                          offset: Offset(2.0, 4.0),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (globals.cusDetailModel!.avatarImgUrl.isNotEmpty)
                            ? Container(
                                width: size.height * 0.12,
                                height: size.height * 0.12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          globals.cusDetailModel!.avatarImgUrl),
                                      fit: BoxFit.fill),
                                ),
                              )
                            : Image.asset(
                                ImageConstant.icPersonal,
                                height: size.height * 0.12,
                                width: size.height * 0.12,
                              ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              globals.cusDetailModel!.fullName,
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              globals.cusDetailModel!.email,
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.018,
                                fontWeight: FontWeight.w400,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.03,
                  left: size.width * 0.02,
                  right: size.width * 0.02,
                ),
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.only(
                    left: size.width * 0.03,
                    right: size.width * 0.03,
                    top: size.height * 0.02,
                    bottom: size.height * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/elderScreen');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageConstant.icManageElder,
                              height: size.height * 0.08,
                              width: size.height * 0.08,
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Text(
                              'Quản lý người thân',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: size.height * 0.026,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/walletScreen');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: size.height * 0.05,
                              height: size.height * 0.05,
                              margin: EdgeInsets.only(
                                left: size.width * 0.03,
                                right: size.width * 0.03,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.wallet,
                                size: size.height * 0.03,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Text(
                              'Ví của bạn',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: size.height * 0.026,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/reportScreen');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: size.height * 0.05,
                              height: size.height * 0.05,
                              margin: EdgeInsets.only(
                                left: size.width * 0.03,
                                right: size.width * 0.03,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.comment,
                                size: size.height * 0.03,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Text(
                              'Phản hồi của bạn',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: size.height * 0.026,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/changePasswordScreen');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageConstant.icPassword,
                              height: size.height * 0.08,
                              width: size.height * 0.08,
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Text(
                              'Tạo/ Đổi mật khẩu',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: size.height * 0.026,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.logout();
                          _elsBox.delete('checkLogin');
                          _elsBox.delete('email');
                          _elsBox.delete('password');
                          _authenBloc.eventController.sink
                              .add(LogoutEvent(context));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageConstant.icSignOut,
                              height: size.height * 0.08,
                              width: size.height * 0.08,
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Text(
                              'Đăng xuất',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: size.height * 0.026,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: size.height * 0.02,
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(context, MaterialPageRoute(builder: (context) => TestDeepLinkScreen(),));
                      //   },
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Image.asset(
                      //         ImageConstant.icSignOut,
                      //         height: size.height * 0.08,
                      //         width: size.height * 0.08,
                      //       ),
                      //       SizedBox(
                      //         width: size.width * 0.03,
                      //       ),
                      //       Text(
                      //         'Deep link',
                      //         style: GoogleFonts.roboto(
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.w500,
                      //           fontSize: size.height * 0.02,
                      //         ),
                      //       ),
                      //       Expanded(
                      //         child: Align(
                      //           alignment: Alignment.centerRight,
                      //           child: Icon(
                      //             Icons.arrow_forward_ios,
                      //             size: size.height * 0.026,
                      //             color: Colors.black54,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.03,
                ),
                child: Text(
                  'Tiện ích',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: size.height * 0.022,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.03,
                  left: size.width * 0.02,
                  right: size.width * 0.02,
                ),
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.only(
                    left: size.width * 0.03,
                    right: size.width * 0.03,
                    top: size.height * 0.02,
                    bottom: size.height * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstant.icSupport,
                            height: size.height * 0.08,
                            width: size.height * 0.08,
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Text(
                            'Hỗ trợ',
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: size.height * 0.02,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: size.height * 0.026,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstant.icAboutapp,
                            height: size.height * 0.08,
                            width: size.height * 0.08,
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Text(
                            'Thông tin ứng dụng',
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: size.height * 0.02,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: size.height * 0.026,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
