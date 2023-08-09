import 'package:age_calculator/age_calculator.dart';
import 'package:elscus/core/models/elder_models/elder_data_model.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/model/elder_model_v2.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/color_constant.dart';

Widget elderItem(BuildContext context, ElderModelV2 elder, ElderModelV2? chosenElder) {
  var size = MediaQuery.of(context).size;
  return Container(
    width: size.width,
    padding: EdgeInsets.all(size.width * 0.05),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(size.height * 0.02),
      color: (elder == chosenElder) ? ColorConstant.primaryColor.withOpacity(0.3) : Colors.white,
      boxShadow: [
        BoxShadow(
          color:(elder == chosenElder) ? Colors.transparent : Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
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
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.024,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.more_horiz,
              size: size.height * 0.03,
              color: ColorConstant.greyElderBox,
            ),
          ],
        ),
        Text(
          "Tuổi: ${AgeCalculator.age(elder.dob).years}",
          style: GoogleFonts.roboto(
            color: ColorConstant.greyElderBox,
            fontWeight: FontWeight.w400,
            fontSize: size.height * 0.022,
          ),
        ),
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
