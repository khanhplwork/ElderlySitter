import 'package:age_calculator/age_calculator.dart';
import 'package:elscus/core/models/elder_models/elder_data_model.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_constant.dart';

Widget elderItem(BuildContext context, ElderDataModel elder) {
  var size = MediaQuery.of(context).size;
  return Container(
    width: size.width,
    height: size.height * 0.17,
    padding: EdgeInsets.all(size.width * 0.05),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(18.5)),
      border: Border.all(
        color: ColorConstant.whiteE3,
        width: 2,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              elder.fullName,
              style: GoogleFonts.roboto(
                color: ColorConstant.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: size.height * 0.024,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.more_horiz,
              size: size.height * 0.03,
              color: ColorConstant.primaryColor,
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: size.height * 0.015)),
        Text(
          "Tuổi: ${AgeCalculator.age(elder.dob).years}",
          style: GoogleFonts.roboto(
            color: ColorConstant.greyElderBox,
            fontWeight: FontWeight.w400,
            fontSize: size.height * 0.022,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: size.height * 0.015)),
        SizedBox(
          width: size.width * 0.9,
          child: Text(
            "Giới tính: ${elder.gender}",
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: GoogleFonts.roboto(
              color: ColorConstant.greyElderBox,
              fontWeight: FontWeight.w400,
              fontSize: size.height * 0.022,
            ),
          ),
        ),
      ],
    ),
  );
}
