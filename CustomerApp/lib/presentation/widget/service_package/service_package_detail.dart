import 'package:elscus/core/models/package_service_models/package_service_data_model.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/core/models/package_service_models/package_service_detail_data_model.dart';
import 'package:elscus/core/utils/my_utils.dart';
import 'package:elscus/presentation/choose_elder_screen/choose_elder_screen.dart';
import 'package:elscus/presentation/home_screen/widget/single_service_item.dart';
import 'package:elscus/presentation/splash_screen/splash_screen.dart';
import 'package:elscus/presentation/widget/dialog/confirm_fill_info_dialog.dart';
import 'package:elscus/process/bloc/package_service_bloc.dart';
import 'package:elscus/process/event/package_service_event.dart';
import 'package:elscus/process/state/package_service_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/color_constant.dart';
import '../../../core/utils/globals.dart' as globals;

// ignore: must_be_immutable
class ServicePackageDetail extends StatefulWidget {
  ServicePackageDetail({Key? key, required this.package}) : super(key: key);
  PackageServiceDataModel package;

  @override
  State<ServicePackageDetail> createState() =>
      // ignore: no_logic_in_create_state
      _ServicePackageDetailState(package: package);
}

class _ServicePackageDetailState extends State<ServicePackageDetail> {
  _ServicePackageDetailState({required this.package});

  PackageServiceDataModel package;
  final _packageServiceBloc = PackageServiceBloc();

  PackageServiceDetailDataModel? packageDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _packageServiceBloc.eventController.sink
        .add(GetPackageDetailPackageServiceEvent(packageID: package.id));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: _packageServiceBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is GetPackageDetailPackageServiceState) {
              packageDetail =
                  (snapshot.data as GetPackageDetailPackageServiceState)
                      .packageDetail;
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: ColorConstant.greySPBg,
                bottomOpacity: 0.0,
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: size.height * 0.03,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: SizedBox(
                width: size.width,
                height: size.height * 0.15,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Text(
                          //   NumberFormat.currency(symbol: "", locale: 'vi-vn')
                          //       .format(MyUtils()
                          //           .getPackageCostPrice(
                          //               packageDetail!.serviceDtos)
                          //           .ceil()),
                          //   style: GoogleFonts.roboto(
                          //     decoration: TextDecoration.lineThrough,
                          //     color: Colors.black,
                          //     fontSize: size.height * 0.02,
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: size.width * 0.03,
                          // ),
                          Text(
                            NumberFormat.currency(symbol: "", locale: 'vi-vn')
                                .format(package.price.ceil()),
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: size.height * 0.026,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.01,
                              left: size.width * 0.02,
                            ),
                            child: Text(
                              "${package.duration} Giờ",
                              style: GoogleFonts.roboto(
                                color: ColorConstant.grey500,
                                fontSize: size.height * 0.022,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.02,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: size.height * 0.055,
                          child: ElevatedButton(
                            onPressed: () {
                              if (globals.cusDetailModel!.checkFullInfo()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChooseElderScreen(
                                        packageServiceID: packageDetail!.id,
                                        totalPrice: packageDetail!.price,
                                        healthStatus:
                                            packageDetail!.healthStatus,
                                        duration: packageDetail!.duration,
                                        packageName: packageDetail!.name,
                                      ),
                                    ));
                              } else {
                                showConfirmFillInfoDialog(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              textStyle: TextStyle(
                                fontSize: size.width * 0.045,
                              ),
                            ),
                            child: const Text("Đặt gói dịch vụ"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Material(
                child: Container(
                  height: size.height,
                  width: size.width,
                  color: ColorConstant.greySPBg,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.appIcon,
                        width: size.width * 0.3,
                        height: size.height * 0.2,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        width: size.width,
                        height: size.height * 0.66,
                        padding: EdgeInsets.only(
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                          top: size.height * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(size.height * 0.05),
                            topRight: Radius.circular(size.height * 0.05),
                          ),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.02,
                                ),
                                child: Text(
                                  package.name,
                                  style: GoogleFonts.roboto(
                                    color: ColorConstant.primaryColor,
                                    fontSize: size.height * 0.04,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                width: size.width,
                                margin: EdgeInsets.only(
                                    top: size.height * 0.02,
                                    bottom: size.height * 0.02,
                                    left: size.width * 0.02,
                                    right: size.width * 0.02),
                                decoration: BoxDecoration(
                                  color: ColorConstant.greySPBg,
                                ),
                              ),
                              ListView.separated(
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.all(0),
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    singleServiceItem(context,
                                        packageDetail!.serviceDtos[index].name),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: size.height * 0.02),
                                itemCount: packageDetail!.serviceDtos.length,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SplashScreen();
          }
        });
  }
}
