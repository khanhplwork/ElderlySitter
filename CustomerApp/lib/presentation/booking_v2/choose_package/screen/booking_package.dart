import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/core/models/package_service_models/package_service_data_model.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/model/elder_model_v2.dart';
import 'package:elscus/presentation/booking_v2/choose_package/bloc/booking_package_bloc.dart';
import 'package:elscus/presentation/booking_v2/choose_package/bloc/booking_package_event.dart';
import 'package:elscus/presentation/booking_v2/choose_package/bloc/booking_package_state.dart';
import 'package:elscus/presentation/booking_v2/choose_package/screen/widget/package_item.dart';
import 'package:elscus/presentation/loading_screen/loading_screen.dart';
import 'package:elscus/presentation/service_package_screen/widget/service_package_item.dart';
import 'package:elscus/presentation/splash_screen/splash_screen.dart';
import 'package:elscus/process/bloc/package_service_bloc.dart';
import 'package:elscus/process/state/package_service_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingPackageScreen extends StatefulWidget {
  BookingPackageScreen({Key? key, required this.elder})
      : super(
          key: key,
        );
  ElderModelV2 elder;

  @override
  State<BookingPackageScreen> createState() =>
      _BookingPackageScreenState(elder: elder);
}

class _BookingPackageScreenState extends State<BookingPackageScreen> {
  _BookingPackageScreenState({required this.elder});

  ElderModelV2 elder;
  final bookingPackageBloc = BookingPackageBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingPackageBloc.elder = elder;
    bookingPackageBloc.eventController.sink
        .add(FetchBookingPackageEvent(statusHealth: elder.healthStatus));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        initialData: LoadingInitBookingPackageState(),
        stream: bookingPackageBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.data is LoadingInitBookingPackageState) {
            return const LoadingScreen();
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
              child: snapshot.data is ErrorBookingPackageState
                  ? Center(child: Text(bookingPackageBloc.errorMessage))
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding:  EdgeInsets.only(
                                top: size.height*0.04,
                                left: size.width*0.05,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: size.height * 0.03,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Chọn gói dịch vụ",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: size.height * 0.03,
                            ),
                          ),
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.only(
                              top: size.height * 0.03,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  bookingPackageBloc.eventController.sink.add(
                                      ClickChooseBookingPackageEvent(
                                          context: context,
                                          package:
                                              bookingPackageBloc.list[index]));
                                },
                                child: packageItem(
                                    context, bookingPackageBloc.list[index]),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: size.height * 0.02,
                            ),
                            itemCount: bookingPackageBloc.list.length,
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          )
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}
