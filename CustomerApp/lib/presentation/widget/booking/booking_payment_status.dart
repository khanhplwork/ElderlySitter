import 'package:elscus/core/constants/color_constant.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget bookingPaymentStatusWidget(BuildContext context, String paymentStatus) {
  var size = MediaQuery.of(context).size;
  if (paymentStatus == "DONE") {
    return Material(
      child: Container(
        padding: EdgeInsets.all(size.width * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.height * 0.01),
          color: ColorConstant.primaryColor.withOpacity(0.2),
        ),
        child: Text(
          "Đã thanh toán",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            color: ColorConstant.primaryColor.withOpacity(0.8),
            fontSize: size.height * 0.018,
          ),
        ),
      ),
    );
  } else {
    return const SizedBox();
  }
}
