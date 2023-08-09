import 'package:elscus/presentation/widget/dialog/confirm_payment_for_booking_dialog.dart';
import 'package:elscus/process/bloc/booking_bloc.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_constant.dart';
import '../../core/constants/image_constant.dart';
import '../../process/event/booking_event.dart';

// ignore: must_be_immutable
class PaymentForBookingScreen extends StatefulWidget {
  PaymentForBookingScreen({Key? key, required this.bookingID})
      : super(key: key);
  String bookingID;

  @override
  State<PaymentForBookingScreen> createState() =>
      // ignore: no_logic_in_create_state
      _PaymentForBookingScreenState(bookingID: bookingID);
}

class _PaymentForBookingScreenState extends State<PaymentForBookingScreen> {
  _PaymentForBookingScreenState({required this.bookingID});

  String bookingID;
  final bookingBloc = BookingBloc();
  bool isCheckedWallet = true;
  bool isCheckedMomo = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: bookingBloc.stateController.stream,
        builder: (context, snapshot) {
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
              title: Padding(
                padding: EdgeInsets.only(left: size.width * 0.06),
                child: const Text(
                  "Thanh Toán Đặt Lịch",
                ),
              ),
              titleTextStyle: GoogleFonts.roboto(
                fontSize: size.height * 0.024,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              color: Colors.white,
              width: size.width,
              height: size.height * 0.12,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: size.width * 0.8,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {

                      showConfirmPaymentForBookingDialog(context, "Xác nhận thanh toán cho đặt lịch này", bookingBloc, bookingID);
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
                    child: const Text("Xác nhận"),
                  ),
                ),
              ),
            ),
            body: Container(
              height: size.height,
              width: size.width,
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  ],
                ),
              ),
            ),
          );
        });
  }
}
