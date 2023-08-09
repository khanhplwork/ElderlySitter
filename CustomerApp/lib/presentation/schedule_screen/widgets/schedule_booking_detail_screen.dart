import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/core/models/booking_models/booking_full_detail_model.dart';
import 'package:elscus/presentation/loading_screen/loading_screen.dart';
import 'package:elscus/presentation/schedule_screen/widgets/floating_action_on_schedule_button.dart';
import 'package:elscus/presentation/schedule_screen/widgets/sitter_detail_panel.dart';
import 'package:elscus/presentation/schedule_screen/widgets/working_date_panel.dart';
import 'package:elscus/presentation/update_booking/screen/update_booking_screen.dart';
import 'package:elscus/process/bloc/booking_bloc.dart';
import 'package:elscus/process/event/booking_event.dart';
import 'package:elscus/process/state/booking_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/color_constant.dart';
import '../../chat_screen/chat_screen.dart';
import 'confirm_action_booking_dialog.dart';
import 'job_description_panel.dart';

class ScheduleBookingDetailScreen extends StatefulWidget {
  const ScheduleBookingDetailScreen({
    Key? key,
    required this.bookingID,
  }) : super(key: key);
  final String bookingID;

  @override
  // ignore: no_logic_in_create_state
  State<ScheduleBookingDetailScreen> createState() =>
      // ignore: no_logic_in_create_state
      _ScheduleBookingDetailScreenState(bookingID: bookingID);
}

class _ScheduleBookingDetailScreenState
    extends State<ScheduleBookingDetailScreen> {
  _ScheduleBookingDetailScreenState({required this.bookingID});

  final String bookingID;
  final _bookingBloc = BookingBloc();
  BookingFullDetailModel? booking;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bookingBloc.eventController.sink
        .add(GetFullDetailBookingEvent(bookingID: bookingID));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TabBar createTabBar() {
      return TabBar(
        indicatorColor: ColorConstant.primaryColor,
        labelPadding: const EdgeInsets.all(10),
        tabs: [
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              "Chi Tiết Lịch Trình",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              textAlign: TextAlign.center,
              "Lịch trình",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
        ],
        isScrollable: true,
      );
    }

    return StreamBuilder<Object>(
        stream: _bookingBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is GetFullDetailBookingState) {
              booking = (snapshot.data as GetFullDetailBookingState).booking;
              _bookingBloc.eventController.add(OtherBookingEvent());
            }
          }
          if (booking != null) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
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
                        "Mô Tả Lịch Trình",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: size.height * 0.024,
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    (booking!.data.status != "PAID" &&
                            booking!.data.status != "CANCEL")
                        ? PopupMenuButton(
                            icon: ImageIcon(
                              AssetImage(ImageConstant.icMoreFunc),
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem<int>(
                                  value: 0,
                                  child: Row(
                                    children: [
                                      ImageIcon(
                                        AssetImage(ImageConstant.icRemoveDate),
                                        size: size.height * 0.03,
                                        color: ColorConstant.primaryColor,
                                      ),
                                      Text(
                                        "  Giảm ngày",
                                        style: GoogleFonts.roboto(
                                          fontSize: size.height * 0.022,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem<int>(
                                  value: 1,
                                  child: Row(
                                    children: [
                                      ImageIcon(
                                        AssetImage(ImageConstant.icAddTime),
                                        size: size.height * 0.03,
                                        color: ColorConstant.primaryColor,
                                      ),
                                      Text(
                                        "  Thêm ngày",
                                        style: GoogleFonts.roboto(
                                          fontSize: size.height * 0.022,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem<int>(
                                  value: 2,
                                  child: Row(
                                    children: [
                                      ImageIcon(
                                        AssetImage(
                                            ImageConstant.icChangeSitter),
                                        size: size.height * 0.03,
                                        color: ColorConstant.primaryColor,
                                      ),
                                      Text(
                                        "  Đổi CSV",
                                        style: GoogleFonts.roboto(
                                          fontSize: size.height * 0.022,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem<int>(
                                  value: 3,
                                  child: Row(
                                    children: [
                                      ImageIcon(
                                        AssetImage(ImageConstant.icChat),
                                        size: size.height * 0.03,
                                        color: ColorConstant.primaryColor,
                                      ),
                                      Text(
                                        "  Trò chuyện",
                                        style: GoogleFonts.roboto(
                                          fontSize: size.height * 0.022,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ];
                            },
                            onSelected: (value) {
                              if (value == 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateBookingScreen(
                                        bookingBloc: _bookingBloc,
                                        idBooking: bookingID,
                                        isReduce: true,
                                        dataBooking: booking!.data),
                                  ),
                                );
                              } else if (value == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateBookingScreen(
                                        bookingBloc: _bookingBloc,
                                        idBooking: bookingID,
                                        isReduce: false,
                                        dataBooking: booking!.data),
                                  ),
                                );
                              } else if (value == 2) {
                                showConfirmActionBookingDialog(
                                    context,
                                    "Mỗi đặt lịch chỉ có thể thay đổi csv 1 lần bạn vẫn muốn thay đổi chứ",
                                    booking!.data);
                              } else if (value == 3) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                        otherID: booking!.data.sitterDto!.id,
                                        otherName:
                                            booking!.data.sitterDto!.fullName,
                                        otherEmail:
                                            booking!.data.sitterDto!.email,
                                        otherAvaUrl:
                                            booking!.data.sitterDto!.image),
                                  ),
                                );
                              }
                            })
                        : const SizedBox(),
                  ],
                  // bottom: createTabBar(),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton:
                    floatingActionOnScheduleButton(context, booking!.data),
                body: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      (booking!.data.sitterDto == null &&
                              booking!.data.status == "PENDING")
                          ? Container(
                              width: size.width,
                              margin: EdgeInsets.only(
                                top: size.height * 0.02,
                                left: size.width * 0.05,
                                right: size.width * 0.05,
                                bottom: size.height * 0.02,
                              ),
                              padding: EdgeInsets.only(
                                top: size.height * 0.015,
                                left: size.width * 0.03,
                                right: size.width * 0.03,
                                bottom: size.height * 0.015,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.02),
                                border: Border.all(
                                  width: 1,
                                  color: ColorConstant.primaryColor
                                      .withOpacity(0.5),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: size.height * 0.035,
                                        height: size.height * 0.035,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                ImageConstant.icSearch),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Hệ Thống đang tìm kiếm chăm sóc viên phù hợp.",
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.height * 0.02,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: size.height * 0.035,
                                        height: size.height * 0.035,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                ImageConstant.icWaiting),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Bạn vui lòng đợi trong giây lát nhé.",
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.height * 0.02,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      (booking!.data.sitterDto != null)
                          ? Container(
                              width: size.width,
                              margin: EdgeInsets.only(
                                top: size.height * 0.02,
                                left: size.width * 0.05,
                                right: size.width * 0.05,
                                bottom: size.height * 0.02,
                              ),
                              padding: EdgeInsets.only(
                                top: size.height * 0.015,
                                left: size.width * 0.03,
                                right: size.width * 0.03,
                                bottom: size.height * 0.015,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.02),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.height * 0.1,
                                    height: size.height * 0.1,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            size.height * 0.015),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            booking!.data.sitterDto!.image,
                                          ),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.03,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Chăm sóc viên",
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500,
                                          fontSize: size.height * 0.02,
                                          color: ColorConstant.primaryColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.015,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.5,
                                        child: Text(
                                          booking!.data.sitterDto!.fullName
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.height * 0.025,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SitterDetailPanel(
                                                        bookingDetail:
                                                            booking!.data),
                                              ));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              size.height * 0.005),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorConstant.primaryColor
                                                .withOpacity(0.1),
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size: size.height * 0.025,
                                            color: ColorConstant.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      createTabBar(),
                      Expanded(
                        child: Container(
                          color: Colors.yellow,
                          child: TabBarView(children: [
                            Material(
                              child: Container(
                                color: Colors.white,
                                width: size.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.03,
                                      ),
                                      JobDescriptionPanel(
                                        bookingDetail: booking!.data,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              child: Container(
                                color: Colors.white,
                                width: size.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.03,
                                      ),
                                      WorkingDatePanel(booking: booking!.data),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const LoadingScreen();
          }
        });
  }
}
