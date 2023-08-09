import 'dart:math';

import 'package:elscus/core/utils/math_lib.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_constant.dart';

Widget dateItem(BuildContext context, DateTime date, DateTime pickedDate) {
  var size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 0.2,
    height: size.height * 0.15,
    decoration: BoxDecoration(
      color: (date.year == pickedDate.year && date.month == pickedDate.month && date.day == pickedDate.day)
          ? ColorConstant.primaryColor.withOpacity(0.3)
          : ColorConstant.greyWeekBox,
      borderRadius: BorderRadius.circular(size.height * 0.015),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${date.day}",
          style: GoogleFonts.roboto(
            fontSize: size.height * 0.022,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          MathLib().getWeekDate(date),
          style: GoogleFonts.roboto(
            fontSize: size.height * 0.02,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
          ),
        ),
      ],
    ),
  );
}
