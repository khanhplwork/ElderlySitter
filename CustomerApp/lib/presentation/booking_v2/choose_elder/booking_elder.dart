import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/bloc/booking_elder_bloc.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/bloc/booking_elder_event.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/bloc/booking_elder_state.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/model/elder_model_v2.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/screen/widget/elder_item_on_choose_elder.dart';
import 'package:flutter/Material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/globals.dart' as globals;

// ignore: must_be_immutable
class ElderBookingScreen extends StatefulWidget {
  const ElderBookingScreen({Key? key}) : super(key: key);

  @override
  State<ElderBookingScreen> createState() =>
      // ignore: no_logic_in_create_state
      _ElderBookingScreenState();
}

class _ElderBookingScreenState extends State<ElderBookingScreen> {
  final elderBookingBloc = ElderBookingBloc();
   ElderModelV2? chosenElder;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    elderBookingBloc.eventController.sink.add(FetchDataEvent());
    print(globals.customerID);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
          padding: EdgeInsets.only(left: size.width * 0.12),
          child: const Text(
            "Chọn người thân",
          ),
        ),
        titleTextStyle: GoogleFonts.roboto(
          fontSize: size.height * 0.024,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: size.width,
        padding: EdgeInsets.only(
          top: size.height * 0.03,
          bottom: size.height * 0.03,
          left: size.width * 0.07,
          right: size.width * 0.07,
        ),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          width: 1,
          color: ColorConstant.primaryColor.withOpacity(0.2),
        ))),
        child: ElevatedButton(
          onPressed: () {
            if (chosenElder==null) {
                            Fluttertoast.showToast(
                  msg: "Bạn cần chọn người thân",
                  toastLength: Toast.LENGTH_SHORT);
            } else {
elderBookingBloc.eventController.sink.add(ClickSubmitElderEvent(context: context, elder: chosenElder!));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: chosenElder==null
                ? Colors.grey
                : ColorConstant.primaryColor,
            padding: EdgeInsets.only(
              top: size.height * 0.02,
              bottom: size.height * 0.02,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.height * 0.01),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Xác nhận",
                style: GoogleFonts.roboto(
                  fontSize: size.height * 0.022,
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<Object>(
          stream: elderBookingBloc.stateController.stream,
          initialData: LoadingDataState(),
          builder: (context, snapshot) {
            if (snapshot.data is LoadingDataState) {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorConstant.primaryColor,
                ),
              );
            }
            if (snapshot.data is ErrorState) {
              return Center(child: Text(elderBookingBloc.error));
            }
            return Material(
              child: Container(
                width: size.width,
                height: size.height,
                padding: EdgeInsets.only(
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      elderBookingBloc.list.isEmpty
                          ? SizedBox()
                          : ListView.separated(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.only(
                                left: size.width * 0.05,
                                right: size.width * 0.05,
                                top: size.height * 0.03,
                              ),
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (chosenElder ==
                                        elderBookingBloc.list[index]) {
                                      chosenElder = null;
                                    } else {
                                      chosenElder =
                                          elderBookingBloc.list[index];
                                    }
                                  });
                                },
                                child: elderItem(
                                    context,
                                    elderBookingBloc.list[index],
                                    chosenElder),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: size.height * 0.02,
                              ),
                              itemCount: elderBookingBloc.list.length,
                            ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
