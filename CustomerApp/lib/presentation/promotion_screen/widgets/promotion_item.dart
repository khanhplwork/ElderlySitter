import 'package:elscus/core/utils/my_utils.dart';
import 'package:elscus/presentation/promotion_screen/widgets/promotion_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/image_constant.dart';
import '../../../core/models/promotion_models/promotion_data_model.dart';

Widget promotionItem(BuildContext context, PromotionDataModel promo) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PromotionDetailScreen(promo: promo),
          ));
    },
    child: Container(
      width: size.width,
      height: size.height * 0.15,
      margin: EdgeInsets.only(
        left: size.width * 0.05,
        right: size.width * 0.05,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageConstant.coupon,
          ),
          fit: BoxFit.fill,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width * 0.12,
          ),
          Container(
            width: size.width * 0.12,
            height: size.width * 0.12,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage((promo.image != null) ? promo.image : ""),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width*0.5,
                child: Text(
                  promo.name,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.02,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                promo.code,
                style: GoogleFonts.roboto(
                  fontSize: size.height * 0.018,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                "Hạn sử dụng đến ngày ${MyUtils().revertYMD(promo.startDate)}",
                style: GoogleFonts.roboto(
                  fontSize: size.height * 0.014,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
