import 'dart:math';

import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/core/utils/my_utils.dart';
import 'package:elscus/presentation/booking_v2/choose_package/model/promotion_model.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/bloc/confirm_pay_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



 
  Widget promotionItemw(Size size,ConfirmPayBloc confirmBloc,Promotion promo) {
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.15,
      margin: EdgeInsets.only(
        left: size.width * 0.05,
        right: size.width * 0.05,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color:confirmBloc.idPromotion==promo.id?ColorConstant.primaryColor:null,
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
            width: size.width * 0.1,
          ),
          Expanded(
            child: Container(
              width: size.width * 0.12,
              height: size.width * 0.12,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage((promo.image.isNotEmpty) ? promo.image : ""),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.12,
          ),
          Expanded(
            flex:4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.5,
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
                  "Hạn sử dụng đến ngày ${MyUtils().revertYMD(promo.endDate)}",
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.014,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
