import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/presentation/pick_time_screen/pick_date_time_screen.dart';
import 'package:elscus/presentation/pick_time_screen/pick_week_time_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ServiceTimeScreen extends StatefulWidget {
  ServiceTimeScreen({
    Key? key,
    required this.elderID,
    required this.packageServiceID,
    required this.totalPrice,
    required this.duration,
    required this.packageName,
    required this.elderName,
  }) : super(key: key);
  String elderID;
  String packageServiceID;
  double totalPrice;
  int duration;
  String packageName;
  String elderName;

  @override
  // ignore: no_logic_in_create_state
  State<ServiceTimeScreen> createState() => _ServiceTimeScreenState(
      elderID: elderID,
      packageServiceID: packageServiceID,
      totalPrice: totalPrice,
      duration: duration,
      packageName: packageName,
      elderName: elderName);
}

class _ServiceTimeScreenState extends State<ServiceTimeScreen> {
  _ServiceTimeScreenState(
      {required this.elderID,
      required this.packageServiceID,
      required this.totalPrice,
      required this.duration,
      required this.packageName,
      required this.elderName});

  String elderID;
  String packageServiceID;
  double totalPrice;
  int duration;
  String packageName;
  String elderName;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
          left: size.width * 0.03,
          right: size.width * 0.03,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.bgService),
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
                height: size.height * 0.05,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: size.height * 0.03,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: size.height * 0.02,
                ),
                width: double.infinity,
                height: size.height * 0.25,
                padding: EdgeInsets.only(
                  left: size.width * 0.07,
                  right: size.width * 0.05,
                  top: size.width * 0.05,
                  bottom: size.width * 0.05,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border:
                      Border.all(color: ColorConstant.primaryColor, width: 1),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 4.0,
                      offset: Offset(2.0, 4.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dịch vụ theo ngày',
                      style: GoogleFonts.roboto(
                        color: ColorConstant.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.026,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          ImageConstant.imgOnlinecalendaramico,
                          width: size.width * 0.3,
                          height: size.height * 0.12,
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  right: size.width * 0.02,
                                ),
                                child: Text(
                                  'Giúp lựa chọn cần buổi nào đặt lịch buổi đó, nhanh chóng tiện lợi. Linh hoạt 4 tiếng hoặc 8 tiếng.',
                                  maxLines: null,
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black45,
                                    fontSize: size.height * 0.016,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder()),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(0)),
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorConstant
                                            .primaryColor), // <-- Button color
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PickDateTimeScreen(
                                            elderID: elderID,
                                            packageServiceID: packageServiceID,
                                            totalPrice: totalPrice,
                                            duration: duration,
                                            packageName: packageName,
                                            elderName: elderName,
                                          ),
                                        ));
                                  },
                                  child: const Icon(Icons.arrow_forward),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: size.height * 0.02,
                ),
                width: double.infinity,
                height: size.height * 0.25,
                padding: EdgeInsets.only(
                  left: size.width * 0.07,
                  right: size.width * 0.07,
                  top: size.width * 0.05,
                  bottom: size.width * 0.05,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border:
                      Border.all(color: ColorConstant.primaryColor, width: 1),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 4.0,
                      offset: Offset(2.0, 4.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dịch vụ theo tuần',
                      style: GoogleFonts.roboto(
                        color: ColorConstant.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.026,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.02,
                            left: size.width * 0.03,
                          ),
                          child: Text(
                            'Cái gì đó.',
                            maxLines: null,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              color: Colors.black45,
                              fontSize: size.height * 0.016,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Image.asset(
                                  ImageConstant.imgDatepickeramico,
                                  width: size.width * 0.3,
                                  height: size.height * 0.1,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder()),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(0)),
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorConstant
                                            .primaryColor), // <-- Button color
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PickWeekTimeScreen(
                                                elderID: elderID,
                                                packageServiceID: packageServiceID,
                                                totalPrice: totalPrice,
                                                duration: duration,
                                                packageName: packageName,
                                                elderName: elderName,
                                              ),
                                        ));
                                  },
                                  child: const Icon(Icons.arrow_forward),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: size.height * 0.02,
                ),
                width: double.infinity,
                height: size.height * 0.25,
                padding: EdgeInsets.only(
                  left: size.width * 0.07,
                  right: size.width * 0.05,
                  top: size.width * 0.05,
                  bottom: size.width * 0.05,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border:
                      Border.all(color: ColorConstant.primaryColor, width: 1),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 4.0,
                      offset: Offset(2.0, 4.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dịch vụ theo tháng',
                      style: GoogleFonts.roboto(
                        color: ColorConstant.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.026,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          ImageConstant.imgDatepickerrafiki,
                          width: size.width * 0.3,
                          height: size.height * 0.12,
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  right: size.width * 0.02,
                                ),
                                child: Text(
                                  'Cái gì đó 2.',
                                  maxLines: null,
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black45,
                                    fontSize: size.height * 0.016,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder()),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(0)),
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorConstant
                                            .primaryColor), // <-- Bu tton color
                                  ),
                                  onPressed: () {},
                                  child: const Icon(Icons.arrow_forward),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
