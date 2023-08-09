import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:elscus/core/models/package_service_models/package_service_data_model.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/presentation/elder_screen/elder_screen.dart';
import 'package:elscus/presentation/history_screen/history_screen.dart';
import 'package:elscus/presentation/promotion_screen/promotion_screen.dart';
import 'package:elscus/presentation/wallet_screen/wallet_screen.dart';
import 'package:elscus/presentation/widget/service_package/service_package_detail.dart';
import 'package:elscus/process/bloc/authen_bloc.dart';
import 'package:elscus/process/bloc/cus_bloc.dart';
import 'package:elscus/process/bloc/package_service_bloc.dart';
import 'package:elscus/process/event/authen_event.dart';
import 'package:elscus/process/event/cus_event.dart';
import 'package:elscus/process/event/package_service_event.dart';
import 'package:elscus/process/state/package_service_state.dart';
import 'package:elscus/process/state/promotion_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/constants/color_constant.dart';
import '../../core/models/promotion_models/promotion_data_model.dart';
import '../../process/bloc/promotion_bloc.dart';
import '../../process/event/promotion_event.dart';
import '../bottom_bar_navigation/bottom_bar_navigation.dart';
import 'widget/service_package_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _packageServiceModel = PackageServiceBloc();
  List<PackageServiceDataModel>? _listPackage;
  final _cusBloc = CusBloc();
  final promotionBloc = PromotionBloc();
  List<PromotionDataModel> listPromo = [];
  final authenBloc = AuthenBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _packageServiceModel.eventController.sink
        .add(GetRandomPackageServiceEvent(count: 3));
    _cusBloc.eventController.sink.add(InitCusDataCusEvent());
    promotionBloc.eventController.sink.add(GetAllPromotionEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return Material(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.bgHomepage),
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
                height: size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageConstant.appIcon,
                      width: size.width * 0.2,
                      height: size.width * 0.2,
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text(
                      'ELS',
                      style: GoogleFonts.roboto(
                        color: ColorConstant.primaryColor,
                        fontSize: size.height * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/notificationScreen');
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            ImageConstant.icNotification,
                            width: size.width * 0.1,
                            height: size.width * 0.1,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: size.width * 0.06,
                              left: size.width * 0.03,
                            ),
                            child: Container(
                              width: size.width * 0.03,
                              height: size.width * 0.03,
                              decoration: BoxDecoration(
                                color: ColorConstant.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.05,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Phím tắt",
                    style: GoogleFonts.roboto(
                      fontSize: size.height * 0.024,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Column(
                children: [
                  SizedBox(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * 0.18,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletScreen(),));
                                },
                                child: Container(
                                  width: size.width * 0.15,
                                  height: size.width * 0.15,
                                  decoration: BoxDecoration(
                                    color:
                                        ColorConstant.yellow1.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.wallet_outlined,
                                    color: ColorConstant.yellow1,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                "Ví",
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.018,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.04,
                        ),
                        Container(
                          width: size.width * 0.18,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/scheduleScreen');
                                },
                                child: Container(
                                  width: size.width * 0.15,
                                  height: size.width * 0.15,
                                  decoration: BoxDecoration(
                                    color:
                                        ColorConstant.blueSky1.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: ImageIcon(
                                    AssetImage(ImageConstant.icCalendar),
                                    color: ColorConstant.blueSky1,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                "Lịch trình",
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.018,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.04,
                        ),
                        Container(
                          width: size.width * 0.18,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BottomBarNavigation(selectedIndex: 3, isBottomNav: true),
                                      ));
                                },
                                child: Container(
                                  width: size.width * 0.15,
                                  height: size.width * 0.15,
                                  decoration: BoxDecoration(
                                    color:
                                        ColorConstant.purple1.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: ImageIcon(
                                    AssetImage(ImageConstant.icHistory2),
                                    color: ColorConstant.purple1,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                "Lịch sử",
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.018,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.04,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ElderScreen(),));
                          },
                          child: Container(
                            width: size.width * 0.2,
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.15,
                                  height: size.width * 0.15,
                                  decoration: BoxDecoration(
                                    color: ColorConstant.red1.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: ImageIcon(
                                    AssetImage(ImageConstant.icManageElder1),
                                    color: ColorConstant.red1,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Text(
                                  "Người thân",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                    fontSize: size.height * 0.018,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              SizedBox(
                height: size.height * 0.03,
              ),
              StreamBuilder<Object>(
                  stream: promotionBloc.stateController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data is GetAllPromotionState) {
                        listPromo =
                            (snapshot.data as GetAllPromotionState).listPromo;
                      }
                    }
                    return Container(
                      width: size.width,
                      margin: EdgeInsets.only(
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(size.height * 0.005),
                        border: Border.all(
                          width: 1,
                          color: ColorConstant.primaryColor.withOpacity(0.5),
                        ),
                        color: ColorConstant.primaryColor.withOpacity(0.1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: size.width * 0.07),
                              child: Text(
                                "Bạn đang có ${listPromo.length} ưu đãi",
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.016,
                                  color: ColorConstant.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PromotionScreen(listPromo: listPromo),
                                  ));
                            },
                            child: Container(
                              decoration: DottedDecoration(
                                color: ColorConstant.primaryColor,
                                strokeWidth: 0.5,
                                linePosition: LinePosition.left,
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                  left: size.width * 0.05,
                                  right: size.width * 0.05,
                                  top: size.height * 0.01,
                                  bottom: size.height * 0.01,
                                ),
                                margin: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  bottom: size.height * 0.01,
                                  left: size.width * 0.03,
                                  right: size.width * 0.03,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorConstant.primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      size.height * 0.005),
                                ),
                                child: Text(
                                  "Xem",
                                  style: GoogleFonts.roboto(
                                    fontSize: size.height * 0.016,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.05,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Những gói phổ biến",
                    style: GoogleFonts.roboto(
                      fontSize: size.height * 0.024,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              StreamBuilder<PackageServiceState>(
                  stream: _packageServiceModel.stateController.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.05,
                        ),
                        child: LoadingAnimationWidget.inkDrop(
                            color: ColorConstant.greenBg,
                            size: size.height * 0.05),
                      );
                    } else {
                      if (snapshot.data is GetRandomPackageServiceState) {
                        _listPackage =
                            (snapshot.data as GetRandomPackageServiceState)
                                .listPackage;
                        return ListView.separated(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(
                            left: size.width * 0.05,
                            right: size.width * 0.05,
                            bottom: size.height * 0.02,
                          ),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ServicePackageDetail(
                                        package: _listPackage![index]),
                                  ));
                            },
                            child: servicePackageItem(
                                context, _listPackage![index]),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: size.height * 0.02,
                          ),
                          itemCount: _listPackage!.length,
                        );
                      } else {
                        return const SizedBox();
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
