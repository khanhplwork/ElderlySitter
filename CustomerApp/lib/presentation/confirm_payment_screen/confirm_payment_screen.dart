import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/core/models/booking_models/booking_form_data_model.dart';
import 'package:elscus/core/utils/my_utils.dart';
import 'package:elscus/presentation/widget/dialog/confirm_booking_dialog.dart';
import 'package:elscus/process/bloc/booking_bloc.dart';
import 'package:elscus/process/event/booking_event.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ConfirmPaymentScreen extends StatefulWidget {
  ConfirmPaymentScreen(
      {Key? key,
      required this.booking,
      required this.packageName,
      required this.elderName,required this.totalPrice})
      : super(key: key);
  BookingDataModel booking;
  String packageName;
  String elderName;
  bool isCheckedWallet = true;
  bool isCheckedMomo = false;
  double totalPrice =0;
  @override
  // ignore: no_logic_in_create_state
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState(
      booking: booking, packageName: packageName, elderName: elderName,totalPrice: totalPrice);
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  _ConfirmPaymentScreenState(
      {required this.booking,
      required this.packageName,
      required this.elderName,
      required this.totalPrice
      });
  BookingDataModel booking;
  String packageName;
  String elderName;
  final _bookingBloc = BookingBloc();
  bool isCheckedWallet = true;
  bool isCheckedMomo = false;
  final descriptionController = TextEditingController();
  double totalPrice;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: _bookingBloc.stateController.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
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
              title: Padding(
                padding: EdgeInsets.only(left: size.width * 0.06),
                child: const Text(
                  "Xác nhận & Thanh toán",
                ),
              ),
              titleTextStyle: GoogleFonts.roboto(
                fontSize: size.height * 0.024,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
              width: size.width,
              height: size.height * 0.15,
              child: Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Tổng cộng:",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: size.height * 0.026,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                           "${(totalPrice * booking.addBookingDetailDtos.length).ceil().toString()} VNĐ",
                          // "${NumberFormat.currency(symbol: "", locale: 'vi-vn').format(booking.totalPrice.ceil())} VNĐ",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: size.height * 0.026,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: size.height * 0.055,
                        child: ElevatedButton(
                          onPressed: () {
                            showConfirmBookingDialog(
                                context,
                                "Xác nhật thanh toán và đặt lịch",
                                _bookingBloc,
                                booking);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            textStyle: TextStyle(
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          child: const Text("Xác nhận"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Material(
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: ColorConstant.greyAccBg,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width,
                        margin: EdgeInsets.only(
                          top: size.height * 0.02,
                        ),
                        padding: EdgeInsets.only(
                          top: size.height * 0.03,
                          bottom: size.height * 0.03,
                          left: size.width * 0.05,
                          right: size.width * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                            bottom: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: size.height * 0.04,
                              color: ColorConstant.primaryColor,
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            SizedBox(
                              width: size.width * 0.7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    elderName,
                                    maxLines: null,
                                    style: GoogleFonts.roboto(
                                      fontSize: size.height * 0.022,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.005,
                                  ),

                                  Text(
                                    booking.address,
                                    maxLines: null,
                                    style: GoogleFonts.roboto(
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.02,
                          left: size.width * 0.05,
                        ),
                        child: Text(
                          "Thông tin công việc",
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.024,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width,
                        margin: EdgeInsets.only(
                          top: size.height * 0.01,
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                        ),
                        padding: EdgeInsets.only(
                          top: size.height * 0.015,
                          bottom: size.height * 0.015,
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(width: 1, color: Colors.grey.shade300),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: size.height * 0.03,
                                  color: ColorConstant.primaryColor,
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                Text(
                                  booking.startDate + " (${booking.addBookingDetailDtos.length} ngày)",
                                  // (booking.startDate != booking.endDate)
                                  //     ? "${MyUtils().revertYMD(booking.startDate)} -> ${MyUtils().revertYMD(booking.endDate)}"
                                  //     : MyUtils().revertYMD(booking.startDate),
                                  style: GoogleFonts.roboto(
                                    fontSize: size.height * 0.022,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  size: size.height * 0.03,
                                  color: ColorConstant.primaryColor,
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                Text(
                                  "${booking.addBookingDetailDtos[0].estimateTime} giờ",
                                  // "${booking.startTime} - ${booking.endTime}",
                                  style: GoogleFonts.roboto(
                                    fontSize: size.height * 0.022,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.work,
                                  size: size.height * 0.03,
                                  color: ColorConstant.primaryColor,
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                SizedBox(

                                  width: size.width * 0.69,

                                  child: Text(
                                    packageName,
                                    style: GoogleFonts.roboto(
                                      fontSize: size.height * 0.022,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.02,
                          left: size.width * 0.05,
                          right: size.width * 0.03,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Ghi chú",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Yêu cầu cho người làm   ",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: size.height * 0.03,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.01,
                          left: size.width * 0.05,
                          right: size.width * 0.03,
                        ),
                        child: TextField(
                          controller: descriptionController,
                          onChanged: (value) {
                            _bookingBloc.eventController.sink.add(FillDescriptionBookingEvent(description: value.toString()));
                            booking.description = value.toString();
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: size.width * 0.04,
                              right: size.width * 0.04,
                              top: size.height * 0.04,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelStyle: GoogleFonts.roboto(
                              color: ColorConstant.grayEE,
                            ),
                            hintText: "Nội dung",
                            //labelText: 'Chi tiết: ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 1, color: ColorConstant.grayEE),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 1,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 6,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.03,
                          left: size.width * 0.05,
                        ),
                        child: Text(
                          "Phương thức thanh toán",
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.024,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width,
                        margin: EdgeInsets.only(
                          top: size.height * 0.02,
                        ),
                        padding: EdgeInsets.only(
                          top: size.height * 0.015,
                          bottom: size.height * 0.015,
                          left: size.width * 0.05,
                          right: size.width * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                            bottom: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageConstant.icMomo,
                              width: size.height * 0.03,
                              height: size.height * 0.03,
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Text(
                              "Momo",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.022,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                              ),
                            ),
                            const Spacer(),
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith((states) => ColorConstant.primaryColor),
                              focusColor: ColorConstant.primaryColor,
                              value: isCheckedMomo,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedMomo = value!;
                                  isCheckedWallet = !value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width,
                        margin: EdgeInsets.only(
                          top: size.height * 0.02,
                        ),
                        padding: EdgeInsets.only(
                          top: size.height * 0.015,
                          bottom: size.height * 0.015,
                          left: size.width * 0.05,
                          right: size.width * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                            bottom: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wallet,
                              color: ColorConstant.primaryColor,
                              size: size.height * 0.03,
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Text(
                              "Ví của bạn",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.022,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                              ),
                            ),
                            const Spacer(),

                            Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith((states) => ColorConstant.primaryColor),
                              value: isCheckedWallet,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedWallet = value!;
                                  isCheckedMomo = !value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.2,
                      )

                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
