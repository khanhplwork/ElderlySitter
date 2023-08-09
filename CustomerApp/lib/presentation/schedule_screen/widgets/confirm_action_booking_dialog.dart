import 'package:elscus/core/models/booking_models/booking_full_detail_data_model.dart';
import 'package:elscus/process/bloc/booking_bloc.dart';
import 'package:elscus/process/state/booking_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/color_constant.dart';
import '../../../core/constants/image_constant.dart';
import '../../../process/event/booking_event.dart';

Future<void> showConfirmActionBookingDialog(BuildContext context,
    String content, BookingFullDetailDataModel booking) async {
  var size = MediaQuery.of(context).size;
  BookingBloc bookingBloc = BookingBloc();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<Object>(
                stream: bookingBloc.stateController.stream,
                builder: (context, snapshot) {
                  return bookingBloc.isLoading
                      ? Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.05,
                              child: CircularProgressIndicator(
                                  color: ColorConstant.primaryColor),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              'Đang xử lý',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: ColorConstant.blue1,
                                fontWeight: FontWeight.w800,
                                fontSize: size.height * 0.035,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageConstant.imgConfirm,
                              width: size.width * 0.64,
                              height: size.width * 0.5,
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              'Bạn có chắc chắn ?',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: ColorConstant.blue1,
                                fontWeight: FontWeight.w800,
                                fontSize: size.height * 0.035,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Text(
                              content,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: ColorConstant.gray4A,
                                fontWeight: FontWeight.normal,
                                fontSize: size.height * 0.022,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 0.28,
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    ),
                                    // ignore: sort_child_properties_last
                                    child: Container(
                                      width: size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Hủy',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: size.height * 0.02,
                                        ),
                                      ),
                                    ),

                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.035,
                                ),
                                Container(
                                  width: size.width * 0.28,
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    ),
                                    // ignore: sort_child_properties_last
                                    child: Container(
                                      width: size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Xác nhận',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: size.height * 0.02,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (content ==
                                          "Xác nhận hủy lịch trình") {
                                        bookingBloc.eventController.sink.add(
                                            CusCancelBooking(
                                                context: context,
                                                bookingID: booking.id,
                                                reason: ""));
                                      } else if (content ==
                                          "Mỗi đặt lịch chỉ có thể thay đổi csv 1 lần bạn vẫn muốn thay đổi chứ") {
                                        bookingBloc.isLoading=true;
                                        bookingBloc.stateController.sink.add(OtherBookingState());
                                        bookingBloc.eventController.sink.add(
                                            CusChangeSitterEvent(
                                                context: context,
                                                bookingID: booking.id));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                }),

          ),
        ),
      );
    },
  );
}
