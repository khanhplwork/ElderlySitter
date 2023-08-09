import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/presentation/timeline_tracking/bloc/timeline_tracking_bloc.dart';
import 'package:elscus/presentation/timeline_tracking/bloc/timeline_tracking_event.dart';
import 'package:elscus/presentation/timeline_tracking/bloc/timeline_tracking_state.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineTrackingScreen extends StatefulWidget {
  TimeLineTrackingScreen({super.key, required this.bookingID});
  String bookingID;

  @override
  State<TimeLineTrackingScreen> createState() =>
      _TimeLineTrackingScreenState(bookingID: bookingID);
}

class _TimeLineTrackingScreenState extends State<TimeLineTrackingScreen> {
  _TimeLineTrackingScreenState({required this.bookingID});
  String bookingID;

  final timelineBloc = TimelineBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timelineBloc.idBooking = bookingID;
    timelineBloc.eventController.sink.add(FetchTimelineEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          // automaticallyImplyLeading: false,
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
        ),
        body: StreamBuilder<Object>(
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
              if (snapshot.data is OtherTimelineState) {
                print("object");
                return timelineBloc.listTimeLine.isEmpty
                    ? Text("Not have data")
                    : SingleChildScrollView(
                        primary: true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ListView.separated(
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.only(
                                  left: size.width * 0.02,
                                  right: size.width * 0.02,
                                  top: size.height * 0.02,
                                ),
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Card(
                                  child: ExpansionTile(
                                    title: Text(
                                      '${timelineBloc.listTimeLine[index].date}',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    children: [
                                      timelineBloc.listTimeLine[index]
                                              .trackingDtoList.isEmpty
                                          ? Text("Chưa có dữ liệu")
                                          : ListView.builder(
                                              itemCount: timelineBloc
                                                  .listTimeLine[index]
                                                  .trackingDtoList
                                                  .length,
                                              scrollDirection: Axis.vertical,
                                              padding: EdgeInsets.only(
                                                left: size.width * 0.02,
                                                right: size.width * 0.02,
                                                top: size.height * 0.02,
                                              ),
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index1) =>
                                                  Column(
                                                children: [
                                                  Container(
                                                    color: Colors.white,
                                                    child: TimelineTile(
                                                      alignment:
                                                          TimelineAlign.end,
                                                      isFirst: true,
                                                      startChild: Container(
                                                        constraints:
                                                            const BoxConstraints(
                                                          minHeight: 80,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                "- " +
                                                                    timelineBloc
                                                                        .listTimeLine[
                                                                            index]
                                                                        .trackingDtoList[
                                                                            index1]
                                                                        .time,
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      size.height *
                                                                          0.02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                "Ghi chú: ${timelineBloc.listTimeLine[index].trackingDtoList[index1].note}",
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
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
                                                          .listTimeLine[index]
                                                          .trackingDtoList[
                                                              index1]
                                                          .image
                                                          .isNotEmpty
                                                      ? Container(
                                                          color: Colors.white,
                                                          child: TimelineTile(
                                                            alignment:
                                                                TimelineAlign
                                                                    .end,
                                                            isFirst: true,
                                                            startChild:
                                                                Container(
                                                                    height: size
                                                                            .height *
                                                                        0.02,
                                                                    width:
                                                                        size.width *
                                                                            0.3,
                                                                    constraints:
                                                                        const BoxConstraints(
                                                                      minHeight:
                                                                          120,
                                                                    ),
                                                                    color: Colors
                                                                        .blueGrey,
                                                                    child: Image
                                                                        .network(
                                                                      timelineBloc
                                                                          .listTimeLine[
                                                                              index]
                                                                          .trackingDtoList[
                                                                              index1]
                                                                          .image,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )),
                                                          ),
                                                        )
                                                      : SizedBox.shrink(),
                                                ],
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: size.height * 0.02,
                                ),
                                itemCount: timelineBloc.listTimeLine.length,
                              ),
                            ],
                          ),
                        ),
                      );
              }
              return SizedBox();
            }));
  }
}
