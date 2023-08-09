import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/models/booking_models/booking_history_data_model.dart';
import 'package:elscus/presentation/loading_screen/loading_screen.dart';
import 'package:elscus/presentation/schedule_screen/widgets/schedule_booking_detail_screen.dart';
import 'package:elscus/presentation/timeline_tracking/screen/widget/booking_item_widget.dart';
import 'package:elscus/presentation/widget/booking/booking_empty.dart';
import 'package:elscus/process/bloc/booking_bloc.dart';
import 'package:elscus/process/event/booking_event.dart';
import 'package:elscus/process/state/booking_state.dart';
import 'package:flutter/Material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TabDataPannel extends StatefulWidget {
  TabDataPannel({Key? key, required this.status})
      : super(
          key: key,
        );
  final String status;

  @override
  State<TabDataPannel> createState() => _TabDataPannelState(status: status);
}

class _TabDataPannelState extends State<TabDataPannel> {
  _TabDataPannelState({required this.status});
  final _bookingBloc = BookingBloc();
  final String status;

  @override
  void initState() {
    // _bookingBloc.stateController.add(LoadingDataState());
    _bookingBloc.eventController.sink.add(FetchDataHistory(status: status));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: _bookingBloc.stateController.stream,
        initialData: LoadingDataState(),
        builder: (context, snapshot) {
          if (snapshot.data is LoadingDataState) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: ColorConstant.primaryColor, size: 50),
            );
          }
          if (snapshot.data is OtherBookingState) {}
          print(_bookingBloc.listData.length);
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
                    _bookingBloc.listData.isEmpty
                        ? Center(
                            //child: Text("Chưa có dữ liệu"),
                            child:
                                bookingEmptyWidget(context, "Chưa có dữ liệu"))
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
                                              bookingID: _bookingBloc
                                                  .listData[index].id),
                                    ));
                              },
                              child: cardPurchagedQuest(
                                  context, _bookingBloc.listData[index]),
                            ),
                            separatorBuilder: (context, index) => Container(
                              width: size.width,
                              margin:
                                  EdgeInsets.only(bottom: size.height * 0.02),
                              color: Colors.black.withOpacity(0.1),
                            ),
                            itemCount: _bookingBloc.listData.length,
                          ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
