import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_constant.dart';

Widget statusInScheduleWidget(BuildContext context, String status) {
  var size = MediaQuery.of(context).size;
  if (status == "ASSIGNED") {
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
        "Đợi đến ngày",
        style: GoogleFonts.roboto(
          color: Colors.blueAccent,
          fontSize: size.height * 0.018,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  } else if (status == "COMPLETED") {
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
        "Đợi thanh toán",
        style: GoogleFonts.roboto(
          color: ColorConstant.primaryColor,
          fontSize: size.height * 0.018,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }else if (status == "PAID") {
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
        "Đã xong",
        style: GoogleFonts.roboto(
          color: ColorConstant.primaryColor,
          fontSize: size.height * 0.018,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }else if (status == "CANCEL") {
    return Container(
      padding: EdgeInsets.only(
        left: size.width * 0.03,
        right: size.width * 0.03,
        top: size.height * 0.005,
        bottom: size.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.red1.withOpacity(0.2),
        borderRadius: BorderRadius.circular(size.height * 0.01),
      ),
      child: Text(
        "Đã hủy",
        style: GoogleFonts.roboto(
          color: ColorConstant.red1,
          fontSize: size.height * 0.018,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  } else if (status == "IN_PROGRESS") {
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
        "Đang Làm",
        style: GoogleFonts.roboto(
          color: Colors.blueAccent ,
          fontSize: size.height * 0.018,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }else {
    return const SizedBox();
  }
}