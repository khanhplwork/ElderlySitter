import 'dart:math';

import 'package:elscus/core/models/booking_models/add_booking_detail_dto.dart';
import 'package:elscus/core/utils/math_lib.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/color_constant.dart';

Widget weekItem(BuildContext context, DateTime date,Map<DateTime,AddBookingDetailDto>  listWorkingDate) {
  var size = MediaQuery.of(context).size;
  bool isPicked = false;
   String keyStr = DateFormat("yyyy-MM-dd").format(date);

        if (listWorkingDate.containsKey(DateFormat("yyyy-MM-dd").parse(keyStr))) {
          isPicked = true;
        }
  // for(DateTime curDate in listWorkingDate){
  //   if(date.year == curDate.year && date.month == curDate.month && date.day == curDate.day){
  //     isPicked = true;
  //   }
  // }

  return Container(
    width: size.width * 0.2,
    height: size.height * 0.15,
    decoration: BoxDecoration(
      color: (isPicked)
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
