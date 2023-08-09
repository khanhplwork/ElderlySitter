import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/color_constant.dart';
import '../../../core/models/package_service_models/package_service_data_model.dart';

Widget servicePackageItem(
    BuildContext context, PackageServiceDataModel package) {
  var size = MediaQuery.of(context).size;
  return Material(
    child: Container(
      padding: EdgeInsets.all(size.width * 0.05),
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.height * 0.015),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.3,
            height: size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: "${package.img}",
              placeholder: (context, url) => CircularProgressIndicator(
                color: ColorConstant.primaryColor,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),

          // (package.img != null && package.img != "")
          // ? Container(
          //     width: size.width * 0.3,
          //     height: size.width * 0.3,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20),
          //       image: DecorationImage(
          //         image: NetworkImage(package.img!),
          //         fit: BoxFit.fill,
          //       ),
          //     ),
          //   )
          // : Container(
          //     width: size.width * 0.3,
          //     height: size.width * 0.3,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //   ),
          SizedBox(
            width: size.width * 0.03,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.46,
                child: Text(
                  package.name,
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.02,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                "${NumberFormat.currency(symbol: "", locale: 'vi-vn').format(package.price.ceil())} VNĐ",
                style: GoogleFonts.roboto(
                  fontSize: size.height * 0.02,
                  color: ColorConstant.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Icon(
                  //   Icons.start,
                  //   color: Colors.black,
                  //   size: size.height * 0.025,
                  // ),
                  Text(
                    "0 lần được chọn",
                    style: GoogleFonts.roboto(
                      fontSize: size.height * 0.016,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    ),
  );
}
