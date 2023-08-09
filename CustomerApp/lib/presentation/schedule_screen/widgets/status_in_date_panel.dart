import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_constant.dart';

Widget statusInDatePanel(BuildContext context, String status){
  var size = MediaQuery.of(context).size;
  if(status == "WAITING"){
    return Container(
      padding: EdgeInsets.only(
        left: size.width * 0.03,
        right: size.width * 0.03,
        top: size.height * 0.005,
        bottom: size.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: Colors.amber.shade600.withOpacity(0.2),
        borderRadius: BorderRadius.circular(size.height * 0.01),
      ),
      child: Text(
        "Đợi đến ngày",
        style: GoogleFonts.roboto(
          color: Colors.brown.shade400,
          fontSize: size.height * 0.018,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }else if(status == "WORKING"){
    return Container(
      padding: EdgeInsets.only(
        left: size.width * 0.03,
        right: size.width * 0.03,
        top: size.height * 0.005,
        bottom: size.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(size.height * 0.01),
      ),
      child: Text(
        "Đang làm",
        style: GoogleFonts.roboto(
          color: Colors.blueAccent,
          fontSize: size.height * 0.018,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }else if(status == "DONE"){
    return Container(
      padding: EdgeInsets.only(
        left: size.width * 0.03,
        right: size.width * 0.03,
        top: size.height * 0.005,
        bottom: size.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(size.height * 0.01),
      ),
      child: Text(
        "Đã làm",
        style: GoogleFonts.roboto(
          color: ColorConstant.primaryColor,
          fontSize: size.height * 0.018,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }else if(status == "CANCEL"){
    return Container(
      padding: EdgeInsets.only(
        left: size.width * 0.03,
        right: size.width * 0.03,
        top: size.height * 0.005,
        bottom: size.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(size.height * 0.01),
      ),
      child: Text(
        "Đã hủy",
        style: GoogleFonts.roboto(
          color: ColorConstant.primaryColor,
          fontSize: size.height * 0.018,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }else{
    return const SizedBox();
  }
}