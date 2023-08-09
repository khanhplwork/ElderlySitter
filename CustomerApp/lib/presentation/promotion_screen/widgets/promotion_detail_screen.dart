import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/core/models/promotion_models/promotion_data_model.dart';
import 'package:elscus/core/utils/my_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class PromotionDetailScreen extends StatefulWidget {
  PromotionDetailScreen({Key? key, required this.promo}) : super(key: key);
  PromotionDataModel promo;

  @override
  State<PromotionDetailScreen> createState() =>
      // ignore: no_logic_in_create_state
      _PromotionDetailScreenState(promo: promo);
}

class _PromotionDetailScreenState extends State<PromotionDetailScreen> {
  _PromotionDetailScreenState({required this.promo});

  PromotionDataModel promo;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            size: size.height * 0.03,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Material(
        color: Colors.white,
        child: Container(
          alignment: Alignment.topCenter,
          width: size.width,
          height: size.height,
          child: Container(
            margin: EdgeInsets.only(
                top: size.height * 0.03,
                left: size.width * 0.05,
                right: size.width * 0.05),
            height: size.height * 0.7,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    ImageConstant.couponDetail,
                  ),
                  fit: BoxFit.fill),
            ),
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.43,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width * 0.15,
                            height: size.width * 0.15,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(promo.image),
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
                              Text(
                                promo.name,
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.02,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Mã KM: ${promo.code}",
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.018,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      SizedBox(
                        width: size.width * 0.75,
                        child: Text(
                          "Thời gian áp dụng từ ${MyUtils().revertYMD(promo.startDate)} đến ${MyUtils().revertYMD(promo.endDate)}",
                          maxLines: null,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.018,
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w400,
                            height: size.height * 0.002,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      SizedBox(
                        width: size.width * 0.75,
                        child: Text(
                          promo.description,
                          maxLines: null,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.018,
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w400,
                            height: size.height * 0.002,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.12,
                  width: size.height * 0.12,
                  margin: EdgeInsets.only(
                    top: size.height * 0.07,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        ImageConstant.appIcon,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
