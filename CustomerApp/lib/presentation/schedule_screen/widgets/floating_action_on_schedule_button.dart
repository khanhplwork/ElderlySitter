import 'package:elscus/presentation/cancel_booking_screen/cancel_booking_screen.dart';
import 'package:elscus/presentation/payment_screen/payment_for_booking_screen.dart';
import 'package:elscus/presentation/rating_sceen/rating_screen.dart';
import 'package:elscus/presentation/report_screen/add_new_report_screen.dart';
import 'package:elscus/presentation/report_screen/report_screen.dart';
import 'package:elscus/presentation/schedule_screen/widgets/confirm_action_booking_dialog.dart';
import 'package:elscus/process/bloc/booking_bloc.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_constant.dart';
import '../../../core/models/booking_models/booking_detail_form_dto.dart';
import '../../../core/models/booking_models/booking_full_detail_data_model.dart';
import '../../../core/utils/my_utils.dart';

Widget floatingActionOnScheduleButton(
    BuildContext context, BookingFullDetailDataModel booking) {
  var size = MediaQuery.of(context).size;
  BookingDetailFormDto? bookingDetail;
  String curDate =
      MyUtils().convertDateToStringInput(DateTime.now()).split("T")[0];
  for (var element in booking.bookingDetailFormDtos) {
    if (element.startDateTime.split("T")[0] == curDate ||
        element.endDateTime.split("T")[0] == curDate) {
      if (element.bookingDetailStatus != "DONE") {
        bookingDetail = element;
        break;
      }
    }
  }

  if (booking.status == "COMPLETED") {
    return Container(
      color: Colors.white,
      width: size.width,
      height: size.height * 0.12,
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.4,
              height: size.height * 0.06,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: ColorConstant.primaryColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size.height * 0.03),
                  ),
                  textStyle: TextStyle(
                    fontSize: size.width * 0.045,
                  ),
                ),
                child: Text(
                  "Phản hồi",
                  style: GoogleFonts.roboto(
                    color: ColorConstant.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.05,
            ),
            SizedBox(
              width: size.width * 0.4,
              height: size.height * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PaymentForBookingScreen(bookingID: booking.id),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size.height * 0.03),
                  ),
                  textStyle: TextStyle(
                    fontSize: size.width * 0.045,
                  ),
                ),
                child: const Text("Thanh Toán"),
              ),
            ),
          ],
        ),
      ),
    );
  } else if (booking.status == "ASSIGNED") {
    if(bookingDetail != null &&  bookingDetail.bookingDetailStatus.toString() == "WORKING"){
      return Container(
        color: Colors.white,
        width: size.width,
        height: size.height * 0.12,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddNewReportScreen(
                              bookingDetailId:
                              (bookingDetail != null) ? bookingDetail.id : "",
                              sitterID: booking.sitterDto!.id),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height * 0.03),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Phản Hồi",
                    style: GoogleFonts.roboto(
                        fontSize: size.height * 0.022,
                        color: ColorConstant.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }else{
      return Container(
        color: Colors.white,
        width: size.width,
        height: size.height * 0.12,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CancelBookingScreen(booking: booking),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height * 0.03),
                    ),
                    textStyle: TextStyle(
                      fontSize: size.width * 0.045,
                    ),
                  ),
                  child: Text(
                    "Hủy Lịch",
                    style: GoogleFonts.roboto(
                        fontSize: size.height * 0.022, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.03,
              ),
              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddNewReportScreen(
                              bookingDetailId:
                              (bookingDetail != null) ? bookingDetail.id : "",
                              sitterID: booking.sitterDto!.id),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height * 0.03),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Phản Hồi",
                    style: GoogleFonts.roboto(
                        fontSize: size.height * 0.022,
                        color: ColorConstant.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  } else if (booking.status == "PENDING") {
    return Container(
      color: Colors.white,
      width: size.width,
      height: size.height * 0.12,
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.4,
              height: size.height * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CancelBookingScreen(booking: booking),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size.height * 0.03),
                  ),
                  textStyle: TextStyle(
                    fontSize: size.width * 0.045,
                  ),
                ),
                child: Text(
                  "Hủy Lịch",
                  style: GoogleFonts.roboto(
                      fontSize: size.height * 0.022, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            SizedBox(
              width: size.width * 0.4,
              height: size.height * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNewReportScreen(
                            bookingDetailId:
                                (bookingDetail != null) ? bookingDetail.id : "",
                            sitterID: booking.sitterDto!.id),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size.height * 0.03),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Phản Hồi",
                  style: GoogleFonts.roboto(
                      fontSize: size.height * 0.022,
                      color: ColorConstant.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } else if (booking.status == "PAID") {
    return Container(
      color: Colors.white,
      width: size.width,
      height: size.height * 0.12,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: size.width * 0.4,
          height: size.height * 0.06,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RatingScreen(
                      bookingID: booking.id, sitter: booking.sitterDto!),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.height * 0.03),
              ),
              textStyle: TextStyle(
                fontSize: size.width * 0.045,
              ),
            ),
            child: const Text("Đánh Giá"),
          ),
        ),
      ),
    );
  } else if (booking.status == "IN_PROGRESS") {
    if(bookingDetail != null &&  bookingDetail.bookingDetailStatus.toString() == "WORKING"){
      return Container(
        color: Colors.white,
        width: size.width,
        height: size.height * 0.12,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddNewReportScreen(
                              bookingDetailId:
                              (bookingDetail != null) ? bookingDetail.id : "",
                              sitterID: booking.sitterDto!.id),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height * 0.03),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Phản Hồi",
                    style: GoogleFonts.roboto(
                        fontSize: size.height * 0.022,
                        color: ColorConstant.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }else{
      return Container(
        color: Colors.white,
        width: size.width,
        height: size.height * 0.12,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddNewReportScreen(
                              bookingDetailId:
                              (bookingDetail != null) ? bookingDetail.id : "",
                              sitterID: booking.sitterDto!.id),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorConstant.primaryColor.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height * 0.03),
                    ),
                    textStyle: TextStyle(
                      fontSize: size.width * 0.045,
                    ),
                  ),
                  child: Text(
                    "Phản Hồi",
                    style: GoogleFonts.roboto(
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.05,
              ),
              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CancelBookingScreen(booking: booking),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height * 0.03),
                    ),
                    textStyle: TextStyle(
                      fontSize: size.width * 0.045,
                    ),
                  ),
                  child: const Text("Hủy Lịch"),
                ),
              ),
            ],
          ),
        ),
      );
    }

  } else {
    return const SizedBox();
  }
}
