import 'package:elscus/presentation/schedule_screen/widgets/booking_item_widget.dart';
import 'package:elscus/presentation/schedule_screen/widgets/schedule_booking_detail_screen.dart';
import 'package:elscus/presentation/timeline_tracking/screen/timeline_tracking_screen.dart';
import 'package:elscus/presentation/timeline_tracking/screen/widget/booking_item_widget.dart';
import 'package:elscus/presentation/timeline_tracking/screen/widget/inprogress_pannel.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/constants/color_constant.dart';
import '../../../core/models/booking_models/booking_history_data_model.dart';
import '../../../process/bloc/booking_bloc.dart';
import '../../../process/event/booking_event.dart';
import '../../../process/state/booking_state.dart';
import '../../history_second_screen/widgets/history_item.dart';
import '../../loading_screen/loading_screen.dart';

class TimelineListInprogress extends StatefulWidget {
  const TimelineListInprogress({Key? key}) : super(key: key);

  @override
  State<TimelineListInprogress> createState() => _InProgressHistoryPanelState();
}

class _InProgressHistoryPanelState extends State<TimelineListInprogress> {
  final _bookingBloc = BookingBloc();
  List<BookingHistoryDataModel> bookingHistoryList = [];
  @override
  void initState() {
    // _bookingBloc.stateController.add(LoadingDataState());
    _bookingBloc.eventController.sink
        .add(GetAllHistoryByStatusBookingEvent(status: "IN_PROGRESS"));
    super.initState();
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
              textAlign: TextAlign.center,
              "Đang tìm CSV",
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
              "Đã có CSV",
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
              "Đang thực hiện",
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

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Lịch trình",
              ),
            ),
            titleTextStyle: GoogleFonts.roboto(
              fontSize: size.height * 0.028,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            bottom: createTabBar(),
          ),
          body: StreamBuilder<Object>(
              stream: _bookingBloc.stateController.stream,
              initialData: LoadingDataState(),
              builder: (context, snapshot) {
                return Material(
                  child: Container(
                    color: Colors.white,
                    child: TabBarView(
                      children: [
                        Material(
                          child: Container(
                            color: Colors.white,
                            width: size.width,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  TabDataPannel(
                                    status: "PENDING",
                                  )
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  TabDataPannel(
                                    status: "ASSIGNED",
                                  )
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  TabDataPannel(
                                    status: "IN_PROGRESS",
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

                if (snapshot.hasData) {
                  if (snapshot.data is LoadingDataState) {
                    return Center(
                      child: LoadingAnimationWidget.discreteCircle(
                          color: ColorConstant.primaryColor, size: 50),
                    );
                  } else if (snapshot.data
                      is GetAllHistoryByStatusBookingState) {
                    for (var element
                        in (snapshot.data as GetAllHistoryByStatusBookingState)
                            .bookingHistoryList
                            .data) {
                      bookingHistoryList.add(element);
                    }
                    _bookingBloc.eventController.sink.add(OtherBookingEvent());
                  }
                }
                if (bookingHistoryList.isNotEmpty) {
                  return Material(
                    child: Container(
                      color: Colors.white,
                      width: size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            (bookingHistoryList.isEmpty)
                                ? const SizedBox()
                                : ListView.separated(
                                    padding: const EdgeInsets.all(0),
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TimeLineTrackingScreen(
                                                      bookingID:
                                                          bookingHistoryList[
                                                                  index]
                                                              .id),
                                            ));
                                      },
                                      // child: bookingItemWidgetV2(
                                      //     context, bookingHistoryList[index]),
                                    ),
                                    separatorBuilder: (context, index) =>
                                        Container(
                                      width: size.width,
                                      height: 1,
                                      margin: EdgeInsets.only(
                                          top: size.height * 0.01,
                                          bottom: size.height * 0.02),
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                    itemCount: bookingHistoryList.length,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              })),
    );
  }
}
