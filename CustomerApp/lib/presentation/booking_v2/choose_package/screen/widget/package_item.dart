import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/core/models/package_service_models/package_service_data_model.dart';
import 'package:elscus/core/models/package_service_models/package_service_detail_data_model.dart';
import 'package:elscus/presentation/booking_v2/choose_package/model/package_model_v2.dart';
import 'package:elscus/presentation/widget/service_package/service_package_detail.dart';
import 'package:elscus/process/event/package_service_event.dart';
import 'package:elscus/process/state/package_service_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


Widget packageItem(
    BuildContext context, PackageModelV2 package) {
     
  var size = MediaQuery.of(context).size;
   return Container(
            width: size.width,
            margin: EdgeInsets.only(
              left: size.width * 0.05,
              right: size.width * 0.05,
            ),
            padding: EdgeInsets.all(size.width * 0.05),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  package.name!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: ColorConstant.primaryColor,
                    fontSize: size.height * 0.026,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  "${NumberFormat.currency(symbol: "", locale: 'vi-vn').format(package.price!.ceil())} VNĐ / ${package.duration} giờ",
                  style: GoogleFonts.roboto(
                    color: ColorConstant.grey600,
                    fontSize: size.height * 0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  color: ColorConstant.greySPBg,
                  height: 1,
                  width: size.width,
                  margin: EdgeInsets.only(
                    top: size.height * 0.02,
                    bottom: size.height * 0.02,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.6,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check,
                              size: size.height * 0.02,
                              color: ColorConstant.primaryColor,
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Expanded(
                              child: Text(
                                package.services![index],
                                maxLines: null,
                                style: GoogleFonts.roboto(
                                  color: ColorConstant.grey600.withOpacity(0.6),
                                  fontSize: size.height * 0.02,
                                ),
                              ),
                            ),
                          ],
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: size.height * 0.005,
                        ),
                        itemCount: package.services!.length,
                      ),
                    ),
                    (package.img.toString() != "")
                        ? Expanded(
                            child: Container(
                              height: size.height * 0.1,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.02),
                                image: DecorationImage(
                                  image: NetworkImage(package.img!),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Container(
                              height: size.height * 0.1,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.02),
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: ElevatedButton(
                //     style: ButtonStyle(
                //       shape: MaterialStateProperty.all(const CircleBorder()),
                //       padding:
                //           MaterialStateProperty.all(const EdgeInsets.all(0)),
                //       backgroundColor: MaterialStateProperty.all(
                //           ColorConstant.primaryColor), // <-- Button color
                //     ),
                //     onPressed: () {
                //         // Navigator.push(
                //         //     context,
                //         //     MaterialPageRoute(
                //         //       builder: (context) =>
                //         //           ServicePackageDetail(package: package),
                //         //     ));
                //     },
                //     child: const Icon(Icons.arrow_forward),
                //   ),
                // ),
              ],
            ),
          );
}
