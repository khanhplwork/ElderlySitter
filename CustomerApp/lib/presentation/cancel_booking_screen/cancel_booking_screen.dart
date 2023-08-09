import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elscus/core/models/booking_models/booking_full_detail_data_model.dart';
import 'package:elscus/core/utils/my_enum.dart';
import 'package:elscus/presentation/cancel_booking_screen/widgets/cancel_booking_content_widget.dart';
import 'package:elscus/presentation/cancel_booking_screen/widgets/confirm_cancel_booking_dialog.dart';
import 'package:elscus/process/bloc/cancel_booking_bloc.dart';
import 'package:elscus/process/event/cancel_booking_event.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/color_constant.dart';
import '../../process/state/cancel_booking_state.dart';

class CancelBookingScreen extends StatefulWidget {
  const CancelBookingScreen({Key? key, required this.booking})
      : super(key: key);
  final BookingFullDetailDataModel booking;

  @override
  State<CancelBookingScreen> createState() =>
      // ignore: no_logic_in_create_state
      _CancelBookingScreenState(booking: booking);
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  _CancelBookingScreenState({required this.booking});

  final BookingFullDetailDataModel booking;
  String title = "Khác";
  final List<String> titleItems = [
    'Thay đổi thông tin đặt lịch',
    'Tôi không muốn đặt lịch nữa',
    'Khác',
  ];
  InfoBookingType _infoBookingType = InfoBookingType.address;
  CancelBookingType _cancelBookingType = CancelBookingType.time;
  final cancelBookingBloc = CancelBookingBloc();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: cancelBookingBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is ChooseInfoBookingCancelBookingState) {
              _infoBookingType =
                  (snapshot.data as ChooseInfoBookingCancelBookingState)
                      .infoBookingType;
              cancelBookingBloc.eventController.sink
                  .add(OtherCancelBookingEvent());
            }
            if (snapshot.data is ChooseTypeCancelBookingState) {
              _cancelBookingType =
                  (snapshot.data as ChooseTypeCancelBookingState)
                      .cancelBookingType;
              cancelBookingBloc.eventController.sink
                  .add(OtherCancelBookingEvent());
            }
          }
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
                  "Xác Nhận Hủy Lịch trình",
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
                      showConfirmCancelBookingDialog(
                          context, cancelBookingBloc, booking.id);
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
                    Container(
                      width: size.width,
                      margin: EdgeInsets.only(
                        top: size.height * 0.01,
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                      ),
                      padding: EdgeInsets.all(size.width * 0.03),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: ColorConstant.primaryColor.withOpacity(0.4),
                        ),
                        borderRadius:
                            BorderRadius.circular(size.height * 0.015),
                      ),
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.warning_outlined,
                            size: size.height * 0.025,
                            color: ColorConstant.primaryColor,
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hủy đặt lịch trước ngày làm việc đầu tiên 36 giờ của đặt lịch sẽ được hoàn tiền 100%",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.height*0.018,
                                  ),
                                ),
                                SizedBox(height: size.height*0.01,),
                                Text(
                                  "Hủy đặt lịch trước ngày làm việc đầu tiên 24 giờ của đặt lịch sẽ được hoàn tiền 70%",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.height*0.018,
                                  ),
                                ),
                                SizedBox(height: size.height*0.01,),
                                Text(
                                  "Hủy đặt lịch trước ngày làm việc đầu tiên 12 giờ của đặt lịch sẽ được hoàn tiền 50%",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.height*0.018,
                                  ),
                                ),
                                SizedBox(height: size.height*0.01,),
                                Text(
                                  "Các yêu cầu hủy đặt lịch kể từ trước 12 giờ của ngày làm việc đầu tiên sẽ không được hoàn tiền",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.height*0.018,
                                  ),
                                ),
                                SizedBox(height: size.height*0.01,),
                                Text(
                                  "Yêu cầu hủy đặt lịch quá 7 lần / năm tài khoản của bạn sẽ bị khóa vĩnh viễn",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height*0.02,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Lý do bạn muốn hủy đặt lịch?',
                          style: GoogleFonts.roboto(
                            color: ColorConstant.primaryColor,
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                      ),
                      child: DropdownButtonFormField2(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: size.width * 0.03,
                            right: size.width * 0.03,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: GoogleFonts.roboto(
                            color: Colors.black,
                          ),
                          //labelText: 'vấn đề: ',
                          errorText: (snapshot.hasError &&
                                  (snapshot.error as Map<String, String>)
                                      .containsKey("title"))
                              ? (snapshot.error as Map<String, String>)["title"]
                              : null,
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
                        hint: const Text(
                          'Vấn đề muốn Phản hồi',
                          style: TextStyle(fontSize: 14),
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.grey,
                        ),
                        iconSize: size.width * 0.06,
                        buttonHeight: size.height * 0.07,
                        buttonPadding: const EdgeInsets.all(0),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        value: title,
                        items: titleItems
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: GoogleFonts.roboto(
                                    fontSize: size.height * 0.022,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            title = value.toString();
                          });
                          cancelBookingBloc.eventController.sink.add(
                              ChooseTitleCancelBookingEvent(
                                  title: value.toString()));
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                      ),
                      child: cancelBookingContentWidget(
                          context,
                          title,
                          cancelBookingBloc,
                          _infoBookingType,
                          _cancelBookingType),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
