
import 'package:elscus/presentation/schedule_screen/widgets/status_in_schedule_widget.dart';
import 'package:elscus/presentation/widget/booking/booking_payment_status.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_constant.dart';
import '../../../core/constants/image_constant.dart';

class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({Key? key}) : super(key: key);

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
          elevation: 0,
          bottomOpacity: 0,
          title: const Text(
            "Chi tiết đặt lịch",
          ),
          titleTextStyle: GoogleFonts.roboto(
            fontSize: size.height * 0.024,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),

        ),
        floatingActionButton: SizedBox(
          width: size.width*0.9,
          height: size.height*0.06,
          child: ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    size.height * 0.03), // <-- Radius
              ),
              backgroundColor: ColorConstant.primaryColor,
              elevation: 1,
              textStyle: TextStyle(
                fontSize: size.height * 0.024,
              ),
            ),
            child: const Text("Đặt lịch lại"),
          ),
        ),
        body: Material(
          child: Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width,
                    padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      top: size.height * 0.02,
                      bottom: size.height * 0.02,
                    ),
                    margin: EdgeInsets.all(size.width * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(size.height * 0.02),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chăm sóc viên",
                          style: GoogleFonts.roboto(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Row(
                          children: [
                            Container(
                              width: size.width * 0.25,
                              height: size.height * 0.12,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(ImageConstant.avatarFemale),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            SizedBox(
                              width: size.width * 0.42,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ngô Thị Thanh Ngân",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "22 tuổi - Nữ",
                                        style: GoogleFonts.roboto(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: size.height * 0.018,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        Icons.female,
                                        color: Colors.red.withOpacity(0.7),
                                        size: size.height * 0.03,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(size.width * 0.01),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    ColorConstant.primaryColor.withOpacity(0.2),
                              ),
                              child: Icon(
                                Icons.more_horiz,
                                color: ColorConstant.primaryColor,
                                size: size.height * 0.03,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: size.width,
                          height: 1,
                          margin: EdgeInsets.only(
                            top: size.height * 0.02,
                            bottom: size.height * 0.02,
                          ),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        Text(
                          "Thân nhân được chăm sóc",
                          style: GoogleFonts.roboto(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Row(
                          children: [
                            Container(
                              width: size.width * 0.25,
                              height: size.height * 0.12,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(ImageConstant.avatarFemale),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            SizedBox(
                              width: size.width * 0.42,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ngô Thị Thanh Ngân",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "22 tuổi - Nữ",
                                        style: GoogleFonts.roboto(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: size.height * 0.018,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        Icons.female,
                                        color: Colors.red.withOpacity(0.7),
                                        size: size.height * 0.03,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(size.width * 0.01),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    ColorConstant.primaryColor.withOpacity(0.2),
                              ),
                              child: Icon(
                                Icons.more_horiz,
                                color: ColorConstant.primaryColor,
                                size: size.height * 0.03,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      top: size.height * 0.02,
                      bottom: size.height * 0.02,
                    ),
                    margin: EdgeInsets.all(size.width * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(size.height * 0.02),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Gói dịch vụ",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Gói cơ bản",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Chăm sóc viên",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Vân Anh",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Ngày",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "20-02-2023",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Thời gian",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "13:00 - 15:00 PM",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Thời gian làm việc",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "4 giờ",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Địa điểm",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "FPT University",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Trạng thái",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            const Spacer(),

                            statusInScheduleWidget(context, "DONE"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      top: size.height * 0.02,
                      bottom: size.height * 0.02,
                    ),
                    margin: EdgeInsets.all(size.width * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(size.height * 0.02),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Chi tiết gói cơ bản",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.6),
                            fontSize: size.height * 0.02,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: size.height * 0.025,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      top: size.height * 0.02,
                      bottom: size.height * 0.02,
                    ),
                    margin: EdgeInsets.all(size.width * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(size.height * 0.02),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Tổng tiền",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "199,000 VNĐ",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Phương thức thanh toán",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "MoMo E-Wallet",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Ngày",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "20 - 02 - 2023 | 10:01:16 AM",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "ID giao dịch",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "SK7263727399",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            SizedBox(width: size.width*0.02,),
                            Icon(Icons.copy, color: ColorConstant.primaryColor, size: size.height*0.03),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Trạng thái",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            const Spacer(),
                            bookingPaymentStatusWidget(context, "DONE"),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        ],
                    ),
                  ),
                  SizedBox(height: size.height*0.1,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
