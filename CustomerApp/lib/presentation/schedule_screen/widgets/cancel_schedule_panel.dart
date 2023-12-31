import 'package:elscus/presentation/schedule_screen/widgets/booking_item_widget.dart';
import 'package:elscus/presentation/schedule_screen/widgets/schedule_booking_detail_screen.dart';
import 'package:elscus/presentation/widget/booking/booking_empty.dart';
import 'package:flutter/Material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/constants/color_constant.dart';
import '../../../core/models/booking_models/booking_history_data_model.dart';
import '../../../process/bloc/booking_bloc.dart';
import '../../../process/event/booking_event.dart';
import '../../../process/state/booking_state.dart';
import '../../history_second_screen/widgets/history_item.dart';
import '../../loading_screen/loading_screen.dart';

class CancelSchedulePanel extends StatefulWidget {
  const CancelSchedulePanel({Key? key}) : super(key: key);

  @override
  State<CancelSchedulePanel> createState() => _CancelHistoryPanelState();
}

class _CancelHistoryPanelState extends State<CancelSchedulePanel> {
  final _bookingBloc = BookingBloc();
  List<BookingHistoryDataModel> bookingHistoryList = [];

  @override
  void initState() {
    // _bookingBloc.stateController.add(LoadingDataState());
    _bookingBloc.eventController.sink
        .add(GetAllHistoryByStatusBookingEvent(status: "CANCEL"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: _bookingBloc.stateController.stream,
        initialData: LoadingDataState(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is LoadingDataState) {
              return Center(
                child: LoadingAnimationWidget.discreteCircle(
                    color: ColorConstant.primaryColor, size: 50),
              );
            } else if (snapshot.data is GetAllHistoryByStatusBookingState) {
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
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ScheduleBookingDetailScreen(
                                                bookingID:
                                                    bookingHistoryList[index]
                                                        .id),
                                      ));
                                },
                                child: bookingItemWidget(
                                    context, bookingHistoryList[index]),
                              ),
                              separatorBuilder: (context, index) => Container(
                                width: size.width,
                                margin:
                                    EdgeInsets.only(bottom: size.height * 0.02),
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
            return bookingEmptyWidget(context, "Chưa có dữ liệu");
          }
        });
  }
}
