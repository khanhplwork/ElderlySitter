import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/core/models/package_service_models/package_service_data_model.dart';
import 'package:elscus/presentation/loading_screen/loading_screen.dart';
import 'package:elscus/presentation/service_package_screen/widget/service_package_item.dart';
import 'package:elscus/presentation/splash_screen/splash_screen.dart';
import 'package:elscus/process/bloc/package_service_bloc.dart';
import 'package:elscus/process/state/package_service_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../process/event/package_service_event.dart';

class ServicePackageScreen extends StatefulWidget {
  const ServicePackageScreen({Key? key}) : super(key: key);

  @override
  State<ServicePackageScreen> createState() => _ServicePackageScreenState();
}

class _ServicePackageScreenState extends State<ServicePackageScreen> {
  final _packageService = PackageServiceBloc();

  List<PackageServiceDataModel>? listPackage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _packageService.eventController.sink
        .add(GetRandomPackageServiceEvent(count: 2));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: _packageService.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is GetRandomPackageServiceState) {
              listPackage =
                  (snapshot.data as GetRandomPackageServiceState).listPackage;
            }
            return Material(
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageConstant.bgServicePackage),
                    fit: BoxFit.fill,
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.08,
                      ),
                      Text(
                        "Chọn gói dịch vụ",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.03,
                        ),
                      ),
                      (listPackage != null && listPackage!.isNotEmpty)
                          ? ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.only(
                                top: size.height * 0.03,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: servicePackageItem(
                                      context, listPackage![index]),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: size.height * 0.02,
                              ),
                              itemCount: listPackage!.length,
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: size.height * 0.05,
                      )
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
