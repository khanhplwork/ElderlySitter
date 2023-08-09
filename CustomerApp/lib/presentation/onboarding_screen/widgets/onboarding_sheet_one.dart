import 'package:elscus/core/constants/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingSheetOne extends StatelessWidget{
  const OnboardingSheetOne({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: size.height*0.05,),
            Align(
              alignment: Alignment.center,
              child: Image.asset(ImageConstant.imgPeoplesearchamico, height: size.height*0.45, width: size.width,),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height*0.1,

              ),
              child: Text(
                "Tìm kiếm xung quanh bạn",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: size.height*0.03,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: size.width,
              margin: EdgeInsets.only(
                left: size.width*0.07,
                top: size.height*0.08,
                right: size.width*0.07,
              ),
              child: Text(
                "Khám phá nhân viên chăm sóc tốt nhất mà bạn muốn theo vị trí hoặc vùng lân cận của bạn",
                maxLines: null,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: size.height*0.018,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}