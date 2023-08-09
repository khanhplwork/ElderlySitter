import 'package:elscus/core/models/booking_models/booking_detail_form_dto.dart';
import 'package:elscus/core/models/booking_models/booking_full_detail_data_model.dart';
import 'package:elscus/core/models/booking_models/sitter_dto.dart';
import 'package:elscus/core/utils/my_utils.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_constant.dart';
import 'confirm_action_booking_dialog.dart';

class SitterDetailPanel extends StatefulWidget {
  const SitterDetailPanel({Key? key, required this.bookingDetail})
      : super(key: key);
  final BookingFullDetailDataModel bookingDetail;

  @override
  // ignore: no_logic_in_create_state
  State<SitterDetailPanel> createState() =>
      // ignore: no_logic_in_create_state
      _SitterDetailPanelState(bookingDetail: bookingDetail);
}

class _SitterDetailPanelState extends State<SitterDetailPanel> {
  _SitterDetailPanelState({required this.bookingDetail});

  final BookingFullDetailDataModel bookingDetail;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: size.height * 0.08,
            bottomOpacity: 0.0,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: size.height * 0.03,
              ),
            ),
            backgroundColor: Colors.white,
            title: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                margin: EdgeInsets.only(
                  top: size.height * 0.01,
                  bottom: size.height * 0.01,
                ),
                child: Text(
                  "Thông Tin Chăm Sóc Viên",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: size.height * 0.024,
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            color: Colors.white,
            width: size.width,
            padding: EdgeInsets.only(
              left: size.width * 0.05,
              right: size.width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: size.height * 0.15,
                    height: size.height * 0.15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            bookingDetail.sitterDto!.image,
                          ),
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.03,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.015,
                    horizontal: size.width * 0.03,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(size.height * 0.015),
                    border: Border.all(
                        width: 1,
                        color: ColorConstant.primaryColor.withOpacity(0.5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * 0.4,
                            child: Text(
                              "Chăm sóc viên:",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.022,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              (bookingDetail.sitterDto as SitterDto).fullName!,
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * 0.4,
                            child: Text(
                              "Giới tính:",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.022,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              (bookingDetail.sitterDto)!.gender,
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * 0.4,
                            child: Text(
                              "Tuổi:",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.022,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${bookingDetail.sitterDto!.age}",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * 0.4,
                            child: Text(
                              "Số điện thoại:",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.022,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              (bookingDetail.sitterDto)!.phone,
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * 0.4,
                            child: Text(
                              "Email:",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.022,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              (bookingDetail.sitterDto as SitterDto).email,
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * 0.4,
                            child: Text(
                              "Đánh giá:",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.022,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${bookingDetail.sitterDto!.rate.ceil()} Điểm",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: size.height * 0.2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
