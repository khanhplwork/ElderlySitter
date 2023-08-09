import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/models/booking_models/booking_full_detail_data_model.dart';
import 'package:elscus/presentation/schedule_screen/widgets/status_in_date_panel.dart';
import 'package:elscus/presentation/timeline_tracking/bloc/timeline_tracking_bloc.dart';
import 'package:elscus/presentation/timeline_tracking/bloc/timeline_tracking_event.dart';
import 'package:elscus/presentation/timeline_tracking/bloc/timeline_tracking_state.dart';
import 'package:elscus/presentation/timeline_tracking/model/timeline_model.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class WorkingDatePanel extends StatefulWidget {
  const WorkingDatePanel({Key? key, required this.booking}) : super(key: key);
  final BookingFullDetailDataModel booking;

  @override
  State<WorkingDatePanel> createState() =>
      // ignore: no_logic_in_create_state
      _WorkingDatePanelState(booking: booking);
}

class _WorkingDatePanelState extends State<WorkingDatePanel> {
  _WorkingDatePanelState({required this.booking});

  final BookingFullDetailDataModel booking;
  final timelineBloc = TimelineBloc();
  @override
  void initState() {
    // TODO: implement initState
    timelineBloc.idBooking = booking.id;
    timelineBloc.eventController.sink.add(FetchTimelineEvent(context: context));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      width: size.width,
      padding: EdgeInsets.only(
        left: size.width * 0.05,
        right: size.width * 0.05,
      ),
      child: StreamBuilder<Object>(
          stream: timelineBloc.stateController.stream,
          initialData: InitTimelineState(),
          builder: (context, snapshot) {
            if (snapshot.data is InitTimelineState) {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorConstant.primaryColor,
                ),
              );
            }

            // print(timelineModelToJson(timelineBloc.listTimeLine));
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Tổng số ngày làm việc: ${booking.bookingDetailFormDtos.length} ngày",
                  //   style: GoogleFonts.roboto(
                  //     fontSize: size.height * 0.022,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Tổng số ngày làm việc: ${booking.bookingDetailFormDtos.length} ngày",
                      //   style: GoogleFonts.roboto(
                      //     fontSize: size.height * 0.022,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(
                          //top: size.height * 0.01,
                          bottom: size.height * 0.01,
                          //left: size.width * 0.05,
                        ),
                        child: Text(
                          "Tổng số ngày làm việc: ",
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.022,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          //top: size.height * 0.01,
                          bottom: size.height * 0.01,
                          left: size.width * 0.01,
                        ),
                        child: Text(
                          "${booking.bookingDetailFormDtos.length} ngày",
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.separated(
                      padding: EdgeInsets.only(
                        top: size.height * 0.01,
                        left: size.width * 0.05,
                      ),
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => ExpansionTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${booking.bookingDetailFormDtos[index].startDateTime.split("T")[0]}',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  child: statusInDatePanel(
                                      context,
                                      booking.bookingDetailFormDtos[index]
                                          .bookingDetailStatus!),
                                )
                              ],
                            ),
                            children: [
                              !timelineBloc.mapdata.containsKey(booking
                                      .bookingDetailFormDtos[index]
                                      .startDateTime
                                      .split("T")[0])
                                  ? Text("Chưa có dữ liệu")
                                  : ListView.builder(
                                      itemCount: timelineBloc
                                          .mapdata[booking
                                              .bookingDetailFormDtos[index]
                                              .startDateTime
                                              .split("T")[0]]!
                                          .trackingDtoList
                                          .length,
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.02,
                                        right: size.width * 0.02,
                                        top: size.height * 0.02,
                                      ),
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index1) => Column(
                                        children: [
                                          Container(
                                            color: Colors.white,
                                            child: TimelineTile(
                                              alignment: TimelineAlign.end,
                                              isFirst: true,
                                              startChild: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minHeight: 80,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "- " +
                                                            timelineBloc
                                                                .mapdata[booking
                                                                    .bookingDetailFormDtos[
                                                                        index]
                                                                    .startDateTime
                                                                    .split(
                                                                        "T")[0]]!
                                                                .trackingDtoList[index1]
                                                                .time,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          color: Colors.black,
                                                          fontSize:
                                                              size.height *
                                                                  0.02,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "Ghi chú: ${timelineBloc.mapdata[booking.bookingDetailFormDtos[index].startDateTime.split("T")[0]]!.trackingDtoList[index1].note}",
                                                        style:
                                                            GoogleFonts.roboto(
                                                          color: ColorConstant
                                                              .grey600,
                                                          fontSize:
                                                              size.height *
                                                                  0.02,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          timelineBloc
                                                  .mapdata[booking
                                                      .bookingDetailFormDtos[
                                                          index]
                                                      .startDateTime
                                                      .split("T")[0]]!
                                                  .trackingDtoList[index1]
                                                  .image
                                                  .isNotEmpty
                                              ? Container(
                                                  color: Colors.white,
                                                  child: TimelineTile(
                                                    alignment:
                                                        TimelineAlign.end,
                                                    isFirst: true,
                                                    startChild: Container(
                                                        height:
                                                            size.height * 0.02,
                                                        width: size.width * 0.3,
                                                        constraints:
                                                            const BoxConstraints(
                                                          minHeight: 120,
                                                        ),
                                                        color: Colors.blueGrey,
                                                        child: Image.network(
                                                          timelineBloc
                                                              .mapdata[booking
                                                                  .bookingDetailFormDtos[
                                                                      index]
                                                                  .startDateTime
                                                                  .split(
                                                                      "T")[0]]!
                                                              .trackingDtoList[
                                                                  index1]
                                                              .image,
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                        ],
                                      ),
                                    )
                            ],
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: size.height * 0.005,
                          ),
                      itemCount: booking.bookingDetailFormDtos.length),
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
