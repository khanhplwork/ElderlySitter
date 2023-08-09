import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/models/booking_models/booking_history_model.dart';
import 'package:elscus/presentation/history_second_screen/widgets/history_item.dart';
import 'package:elscus/presentation/loading_screen/loading_screen.dart';
import 'package:elscus/process/bloc/booking_bloc.dart';
import 'package:elscus/process/event/booking_event.dart';
import 'package:elscus/process/state/booking_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HistorySecondScreen extends StatefulWidget {
  const HistorySecondScreen({Key? key}) : super(key: key);

  @override
  State<HistorySecondScreen> createState() => _HistorySecondScreenState();
}

class _HistorySecondScreenState extends State<HistorySecondScreen> {
  final _bookingBloc = BookingBloc();
  BookingHistoryModel? bookingHistoryList;

  @override
  void initState() {
    // _bookingBloc.stateController.add(LoadingDataState());
    _bookingBloc.eventController.sink.add(GetAllHistoryBookingEvent());
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
          } else if (snapshot.data is GetAllHistoryBookingState) {
            bookingHistoryList =
                (snapshot.data as GetAllHistoryBookingState).bookingHistoryList;
          }
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: size.height * 0.08,
                elevation: 0.0,
                automaticallyImplyLeading: false,
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
                // ImageIcon(
                //   AssetImage(ImageConstant.appLogo),
                //   size: size.width * 0.08,
                //   color: ColorConstant.primaryColor,
                // ),
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
                      "Lịch sử của tôi",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: size.height * 0.03,
                      ),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_outlined,
                      size: size.height * 0.03,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              body: Material(
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
                        (bookingHistoryList!.data.isEmpty)
                            ? const Text("chưa có data")
                            : ListView.separated(
                                padding: const EdgeInsets.all(0),
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           RequestDetailScreen(
                                    //               bookingID: bookingHistoryList!
                                    //                   .data[index].id)),
                                    // );
                                  },
                                  child: historyItem(
                                      context, bookingHistoryList!.data[index]),
                                ),
                                separatorBuilder: (context, index) => Container(
                                  width: size.width,
                                  height: 1,
                                  margin: EdgeInsets.only(
                                      top: size.height * 0.01,
                                      bottom: size.height * 0.02),
                                  color: Colors.black.withOpacity(0.1),
                                ),
                                itemCount: bookingHistoryList!.data.length,
                              ),
                      ],
                    ),
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
