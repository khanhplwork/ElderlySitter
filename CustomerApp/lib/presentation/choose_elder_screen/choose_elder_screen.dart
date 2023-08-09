import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/models/elder_models/elder_data_model.dart';
import 'package:elscus/core/models/elder_models/elder_detail_data_model.dart';
import 'package:elscus/presentation/choose_elder_screen/widgets/alert_choose_elder_dialog.dart';
import 'package:elscus/presentation/choose_elder_screen/widgets/elder_item_on_choose_elder.dart';
import 'package:elscus/presentation/loading_screen/loading_screen.dart';
import 'package:elscus/presentation/service_time_screen/service_time_screen.dart';
import 'package:elscus/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../process/bloc/elder_bloc.dart';
import '../../process/event/elder_event.dart';
import '../../process/state/elder_state.dart';

// ignore: must_be_immutable
class ChooseElderScreen extends StatefulWidget {
  ChooseElderScreen({
    Key? key,
    required this.packageServiceID,
    required this.totalPrice,
    required this.healthStatus,
    required this.duration,
    required this.packageName,
  }) : super(key: key);
  String packageServiceID;
  double totalPrice;
  String healthStatus;
  int duration;
  String packageName;

  @override
  State<ChooseElderScreen> createState() =>
      // ignore: no_logic_in_create_state
  _ChooseElderScreenState(
    packageServiceID: packageServiceID,
    totalPrice: totalPrice,
    healthStatus: healthStatus,
    duration: duration,
    packageName: packageName,);
}

class _ChooseElderScreenState extends State<ChooseElderScreen> {
  _ChooseElderScreenState({
    required this.packageServiceID,
    required this.totalPrice,
    required this.healthStatus,
    required this.duration,
    required this.packageName,
  });

  String packageServiceID;
  double totalPrice;
  String healthStatus;
  int duration;
  String packageName;
  final _elderBloc = ElderBloc();
  String chosenElderID = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (healthStatus.isNotEmpty) {
      _elderBloc.eventController.sink
          .add(GetByHealthStatusElderEvent(healthStatus: healthStatus));
    } else {
      _elderBloc.eventController.sink.add(GetAllElderEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    return StreamBuilder<Object>(
        stream: _elderBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String getElderName() {
              String elderName = "";
              if ((snapshot.data is GetAllElderState &&
                  (snapshot.data as GetAllElderState)
                      .elderList
                      .data
                      .isNotEmpty)) {
                for (ElderDataModel data in (snapshot
                    .data as GetAllElderState).elderList.data) {
                  if (data.id == chosenElderID) {
                    elderName = data.fullName;
                  }
                }
              } else {
                for (ElderDataModel data in (snapshot
                    .data as GetByHealthStatusElderState).elderList.data) {
                  if (data.id == chosenElderID) {
                    elderName = data.fullName;
                  }
                }
              }

              return elderName;
            }
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
              floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
                          color: ColorConstant.greyElderBox.withOpacity(0.2),
                        ))),
                child: ElevatedButton(
                  onPressed: () {
                    if (chosenElderID.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ServiceTimeScreen(
                                  elderID: chosenElderID,
                                  packageServiceID: packageServiceID,
                                  totalPrice: totalPrice,
                                  duration: duration,
                                  packageName: packageName,
                                  elderName: getElderName(),
                                ),
                          ));
                    } else {
                      showChooseElderAlertDialog(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor,
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
                      // Image.asset(
                      //   ImageConstant.icAddNewElder,
                      //   width: size.height * 0.03,
                      //   height: size.height * 0.03,
                      // ),
                      // SizedBox(
                      //   width: size.width * 0.03,
                      // ),
                      // Text(
                      //   "Thêm người thân mới",
                      //   style: GoogleFonts.roboto(
                      //     fontSize: size.height * 0.022,
                      //   ),
                      // ),
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
              body: Material(
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
                        (snapshot.data is GetByHealthStatusElderState &&
                            (snapshot.data as GetByHealthStatusElderState)
                                .elderList
                                .data
                                .isNotEmpty)
                            ? ListView.separated(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(
                            left: size.width * 0.05,
                            right: size.width * 0.05,
                            top: size.height * 0.03,
                          ),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    chosenElderID = (snapshot.data
                                    as GetByHealthStatusElderState)
                                        .elderList
                                        .data[index]
                                        .id;
                                  });
                                },
                                child: elderItemOnChooseElder(
                                    context,
                                    (snapshot.data
                                    as GetByHealthStatusElderState)
                                        .elderList
                                        .data[index],
                                    chosenElderID),
                              ),
                          separatorBuilder: (context, index) =>
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                          itemCount: (snapshot.data
                          as GetByHealthStatusElderState)
                              .elderList
                              .data
                              .length,
                        )
                            : const SizedBox(),
                        (snapshot.data is GetAllElderState &&
                            (snapshot.data as GetAllElderState)
                                .elderList
                                .data
                                .isNotEmpty)
                            ? ListView.separated(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(
                            left: size.width * 0.05,
                            right: size.width * 0.05,
                            top: size.height * 0.03,
                          ),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    chosenElderID =
                                        (snapshot.data as GetAllElderState)
                                            .elderList
                                            .data[index]
                                            .id;
                                  });
                                },
                                child: elderItemOnChooseElder(
                                    context,
                                    (snapshot.data as GetAllElderState)
                                        .elderList
                                        .data[index],
                                    chosenElderID),
                              ),
                          separatorBuilder: (context, index) =>
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                          itemCount: (snapshot.data as GetAllElderState)
                              .elderList
                              .data
                              .length,
                        )
                            : const SizedBox(),
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
