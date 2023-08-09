import 'package:elscus/core/constants/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingSheetTwo extends StatelessWidget{
  const OnboardingSheetTwo({super.key});

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
              child: Image.asset(ImageConstant.imgNextoptionpana, height: size.height*0.45, width: size.width,),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height*0.1,

              ),
              child: Text(
                "Đặt lịch dễ dàng",
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
                "Chọn khoảng thời gian bạn muốn đặt lịch",
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