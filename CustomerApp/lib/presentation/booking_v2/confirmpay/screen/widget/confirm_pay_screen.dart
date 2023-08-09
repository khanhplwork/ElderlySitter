import 'dart:developer';

import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/bloc/booking_input_infor_bloc.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/screen/booking_pick_address.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/bloc/confirm_pay_bloc.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/bloc/confirm_pay_event.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/bloc/confirm_pay_state.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/screen/widget/fail_pay_screen.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/screen/widget/promotion_widget.dart';
import 'package:elscus/presentation/success_screen/success_screen.dart';
import 'package:elscus/presentation/widget/dialog/fail_dialog.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';

class ConfirmPayScreen extends StatefulWidget {
  ConfirmPayScreen({super.key, required this.bookingInputBloc});
  BookingInputInforBloc bookingInputBloc;
  @override
  State<ConfirmPayScreen> createState() =>
      _ConfirmPayScreenState(bookingInputBloc: bookingInputBloc);
}

enum SingingCharacter { lafayette, jefferson }

class _ConfirmPayScreenState extends State<ConfirmPayScreen> {
  _ConfirmPayScreenState({required this.bookingInputBloc});
  BookingInputInforBloc bookingInputBloc;
  final confirmPayBloc = ConfirmPayBloc();
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    confirmPayBloc.eventController.sink.add(FetchDataWalletEvent());
    initDynamicLinks();
    bookingInputBloc.datesFinal.forEach((element) {
      confirmPayBloc.dates.add(DateFormat("yyyy-MM-dd").format(element!));
    });
  }
    Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParams = uri.path;
      log("dcf ${queryParams}");
      if (queryParams.isNotEmpty) {
        if (queryParams == "/success") {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SuccessScreen(
                    content:
                        "Thanh toán thành công. Cảm ơn bạn đã sử dụng dịch vụ",
                    buttonName: "Trang chủ",
                    navigatorPath: '/homeScreen'),
              ),
              (route) => false);
        } else {
          showFailDialog(
              context, "Thanh toán không thành công. Vui lòng thử lại sau");
        }
      } else {}
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Trang thanh toán"),
            backgroundColor: ColorConstant.primaryColor,
            centerTitle: true,
          ),
          body: StreamBuilder<Object>(
            stream: confirmPayBloc.stateController.stream,
            initialData: LoadingConfirmPayState(),
            builder: (context, snapshot) {
              if (snapshot.data is LoadingConfirmPayState) {
                return Center(
                    child: CircularProgressIndicator(
                  color: ColorConstant.primaryColor,
                ));
              }
              if (snapshot.data is OtherConfirmPayState) {}
              if (snapshot.data is ErrorConfirmPayState) {
                print("ngộ");
                // showAboutDialog(context: context,children: Container(child: Text((snapshot.data as ErrorConfirmPayState).message)))
                return FailPayWidget(
                  message: (snapshot.data as ErrorConfirmPayState).message,
                  blocConfirm: confirmPayBloc,
                );
              }

              return Stack(
                children: [
                  SizedBox(
                    height: size.height,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BookingPickAddressScreen(
                                            bookingInputBloc: bookingInputBloc),
                                  ),
                                );
                              },
                              leading: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Icon(
                                        Icons.location_on,
                                        size: 30,
                                      ))),
                              title: Text(
                                bookingInputBloc
                                    .modelSearch!.structuredFormatting.mainText,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  bookingInputBloc.modelSearch!.description),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Đặt lịch của bạn",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Tên gói",
                                      style: GoogleFonts.roboto(
                                        color: ColorConstant.grey600,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${bookingInputBloc.package.name}",
                                      // Text(
                                      // "${MoneyFormatter(amount: bookingInputBloc.package.price).output.withoutFractionDigits} VNĐ",
                                      style: GoogleFonts.roboto(
                                        color: ColorConstant.grey600,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Giá gói",
                                      style: GoogleFonts.roboto(
                                        color: ColorConstant.grey600,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      // "${bookingInputBloc.package.name}",
                                      // Text(
                                      "${MoneyFormatter(amount: bookingInputBloc.package.price!).output.withoutFractionDigits} VNĐ",
                                      style: GoogleFonts.roboto(
                                        color: ColorConstant.grey600,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Thời gian bắt đầu",
                                      style: GoogleFonts.roboto(
                                        color: ColorConstant.grey600,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${bookingInputBloc.slotPicked.slots.split(" ")[1].split("-")[0]}",
                                      style: GoogleFonts.roboto(
                                        color: ColorConstant.grey600,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Tổng số ngày",
                                      style: GoogleFonts.roboto(
                                        color: ColorConstant.grey600,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${bookingInputBloc.datesFinal.length} ngày",
                                      style: GoogleFonts.roboto(
                                        color: ColorConstant.grey600,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              "Trong đó: ",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            bookingInputBloc.checkPriceModel!.datePriceInform
                                        .midnight !=
                                    null
                                ? ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Giờ đêm ( ${(bookingInputBloc.checkPriceModel!.datePriceInform.midnight!.percent*100).truncate()} % ) :",
                                                style: GoogleFonts.roboto(
                                                  color: ColorConstant.grey600,
                                                  fontSize: size.height * 0.02,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                "${bookingInputBloc.checkPriceModel!.datePriceInform.midnight!.date} ngày",
                                                style: GoogleFonts.roboto(
                                                  color: ColorConstant.grey600,
                                                  fontSize: size.height * 0.02,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${MoneyFormatter(amount: bookingInputBloc.checkPriceModel!.datePriceInform.midnight!.price).output.withoutFractionDigits} VNĐ",
                                            style: GoogleFonts.roboto(
                                              color: ColorConstant.grey600,
                                              fontSize: size.height * 0.02,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            bookingInputBloc.checkPriceModel!.datePriceInform
                                        .normal !=
                                    null
                                ? ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Ngày bình thường :",
                                                style: GoogleFonts.roboto(
                                                  color: ColorConstant.grey600,
                                                  fontSize: size.height * 0.02,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              // ${bookingInputBloc.checkPriceModel!.datePriceInform.normal!.date} ngày
                                              Text(
                                                "${bookingInputBloc.checkPriceModel!.datePriceInform.normal!.date} ngày",
                                                style: GoogleFonts.roboto(
                                                  color: ColorConstant.grey600,
                                                  fontSize: size.height * 0.02,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${MoneyFormatter(amount: bookingInputBloc.checkPriceModel!.datePriceInform.normal!.price).output.withoutFractionDigits} VNĐ",
                                            style: GoogleFonts.roboto(
                                              color: ColorConstant.grey600,
                                              fontSize: size.height * 0.02,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            bookingInputBloc.checkPriceModel!.datePriceInform
                                        .holiday !=
                                    null
                                ? ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Ngày lễ ( ${(bookingInputBloc.checkPriceModel!.datePriceInform.holiday!.percent*100).truncate()} % ) :",
                                                style: GoogleFonts.roboto(
                                                  color: ColorConstant.grey600,
                                                  fontSize: size.height * 0.02,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              // ${bookingInputBloc.checkPriceModel!.datePriceInform.holiday!.date} ngày
                                              Text(
                                                "${bookingInputBloc.checkPriceModel!.datePriceInform.holiday!.date} ngày",
                                                style: GoogleFonts.roboto(
                                                  color: ColorConstant.grey600,
                                                  fontSize: size.height * 0.02,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${MoneyFormatter(amount: bookingInputBloc.checkPriceModel!.datePriceInform.holiday!.price).output.withoutFractionDigits} VNĐ",
                                            style: GoogleFonts.roboto(
                                              color: ColorConstant.grey600,
                                              fontSize: size.height * 0.02,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            bookingInputBloc.checkPriceModel!.datePriceInform
                                        .weekend !=
                                    null
                                ? ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Cuối tuần ( ${(bookingInputBloc.checkPriceModel!.datePriceInform.weekend!.percent*100).truncate()} % ) :",
                                                style: GoogleFonts.roboto(
                                                  color: ColorConstant.grey600,
                                                  fontSize: size.height * 0.02,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              // ${bookingInputBloc.checkPriceModel!.datePriceInform.weekend!.date} ngày
                                              Text(
                                                "${bookingInputBloc.checkPriceModel!.datePriceInform.weekend!.date} ngày",
                                                style: GoogleFonts.roboto(
                                                  color: ColorConstant.grey600,
                                                  fontSize: size.height * 0.02,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${MoneyFormatter(amount: bookingInputBloc.checkPriceModel!.datePriceInform.weekend!.price).output.withoutFractionDigits} VNĐ",
                                            style: GoogleFonts.roboto(
                                              color: ColorConstant.grey600,
                                              fontSize: size.height * 0.02,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            Container(
                              color: Colors.blueGrey,
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Tạm tính:",
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                        "${MoneyFormatter(amount: bookingInputBloc.checkPriceModel!.totalPrice).output.withoutFractionDigits} VNĐ",
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: size.height * 0.02,
                                          fontWeight: FontWeight.w500,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            (confirmPayBloc.checkPriceModel != null &&
                                    confirmPayBloc
                                            .checkPriceModel?.discountPrice !=
                                        0)
                                ? Container(
                                    color: Colors.blueGrey,
                                    child: ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Áp dụng mã giảm giá:",
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: size.height * 0.02,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                              "- ${MoneyFormatter(amount: confirmPayBloc.checkPriceModel!.discountPrice).output.withoutFractionDigits} VNĐ",
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: size.height * 0.02,
                                                fontWeight: FontWeight.w500,
                                              ))
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                            SizedBox(
                              height: size.height * 0.2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: size.height * 0.13, width: size.width,
                      // width:double.infinity,
                      color: Colors.blueGrey,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //  Expanded(
                                //   flex: 2,
                                //    child: ListTile(
                                //     leading:  confirmPayBloc.numPayment == 1
                                //             ? Image.asset(
                                //                 "assets/images/momo-icon.png",
                                //                 fit: BoxFit.contain,
                                //               )
                                //             : Icon(Icons.wallet),
                                //  title:  Text(
                                //           confirmPayBloc.numPayment == 1
                                //               ? "MOMO"
                                //               : "Ví",
                                //           style: GoogleFonts.roboto(
                                //             color: Colors.white,
                                //             fontSize: size.height * 0.02,
                                //             fontWeight: FontWeight.w500,
                                //           ),
                                //         ),
                                //         trailing:  Icon(Icons.keyboard_arrow_up),
                                //    ),
                                //  ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    confirmPayBloc.numPayment == 1
                                        ? Image.asset(
                                            "assets/images/momo-icon.png",
                                            fit: BoxFit.contain,
                                          )
                                        : Icon(Icons.wallet),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      confirmPayBloc.numPayment == 1
                                          ? "MOMO"
                                          : "Ví",
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          SingingCharacter? _character =
                                              SingingCharacter.lafayette;
                                          showModalBottomSheet(
                                              context: context,
                                              barrierColor: Colors.transparent,
                                              // backgroundColor: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              enableDrag: false,
                                              builder: (builder) {
                                                return StatefulBuilder(
                                                  builder: (context,
                                                          setStateModal) =>
                                                      Container(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 10),
                                                          height:
                                                              size.height * 0.4,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .grey.shade50,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  topRight:
                                                                      Radius.circular(
                                                                          20))),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "Phương thức thanh toán",
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      size.height *
                                                                          0.02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              ListTile(
                                                                onTap: () {
                                                                  confirmPayBloc
                                                                      .numPayment = 0;
                                                                  confirmPayBloc
                                                                      .stateController
                                                                      .sink
                                                                      .add(
                                                                          OtherConfirmPayState());
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                leading: Icon(
                                                                    Icons
                                                                        .wallet),
                                                                title:
                                                                    Text("Ví"),
                                                                trailing:
                                                                    confirmPayBloc.numPayment ==
                                                                            0
                                                                        ? Icon(
                                                                            Icons.check,
                                                                            size:
                                                                                30,
                                                                            color:
                                                                                ColorConstant.primaryColor,
                                                                          )
                                                                        : null,
                                                              ),
                                                              ListTile(
                                                                  onTap: () {
                                                                    confirmPayBloc
                                                                        .numPayment = 1;
                                                                    confirmPayBloc
                                                                        .stateController
                                                                        .sink
                                                                        .add(
                                                                            OtherConfirmPayState());
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  leading: SizedBox(
                                                                      height:
                                                                          30,
                                                                      width: 30,
                                                                      child: Image
                                                                          .asset(
                                                                              'assets/images/momo-icon.png')),
                                                                  title: Text(
                                                                      "MOMO"),
                                                                  trailing:
                                                                      confirmPayBloc.numPayment ==
                                                                              1
                                                                          ? Icon(
                                                                              Icons.check,
                                                                              size: 30,
                                                                              color: ColorConstant.primaryColor,
                                                                            )
                                                                          : null
                                                                  //  trailing: Icon(Icons.check),
                                                                  )
                                                            ],
                                                          )),
                                                );
                                              });
                                        },
                                        icon: Icon(Icons.keyboard_arrow_up))
                                  ],
                                ),
                                Container(
                                  color: Colors.white,
                                  height: size.height * 0.03,
                                  width: 3,
                                ),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        barrierColor: Colors.transparent,
                                        // backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        enableDrag: false,
                                        builder: (builder) {
                                          return StatefulBuilder(builder:
                                              (context, setStateModal) {
                                            return Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 10),
                                                height: size.height * 0.8,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade50,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20))),
                                                child:
                                                    confirmPayBloc.promotionList
                                                            .isEmpty
                                                        ? Center(
                                                            child: Text(
                                                                "Bạn hiện chưa có mã giảm giá nào"),
                                                          )
                                                        : Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Spacer(),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      icon: Icon(
                                                                          Icons
                                                                              .close))
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                child: ListView
                                                                    .separated(
                                                                  shrinkWrap:
                                                                      true,
                                                                  separatorBuilder:
                                                                      (context,
                                                                              index) =>
                                                                          SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  itemCount:
                                                                      confirmPayBloc
                                                                          .promotionList
                                                                          .length,
                                                                  itemBuilder: (context,
                                                                          index) =>
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            if (confirmPayBloc.idPromotion !=
                                                                                confirmPayBloc.promotionList[index].id) {
                                                                              confirmPayBloc.idPromotion = confirmPayBloc.promotionList[index].id;
                                                                            } else {
                                                                              confirmPayBloc.idPromotion = "";
                                                                            }
                                                                            confirmPayBloc.eventController.sink.add(ClickChoosePromotion(
                                                                                bookingInputBloc: bookingInputBloc,
                                                                                context: context));
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              promotionItemw(
                                                                            size,
                                                                            confirmPayBloc,
                                                                            confirmPayBloc.promotionList[index],
                                                                          )),
                                                                ),
                                                              ),
                                                            ],
                                                          ));
                                          });
                                        });
                                  },
                                  child: Text(
                                    "Thêm coupon",
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Tổng cộng",
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: size.height * 0.02,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${MoneyFormatter(amount: (confirmPayBloc.checkPriceModel != null && confirmPayBloc.checkPriceModel?.afterDiscountPrice != 0) ? confirmPayBloc.checkPriceModel!.afterDiscountPrice : bookingInputBloc.checkPriceModel!.totalPrice).output.withoutFractionDigits} VNĐ",
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: size.height * 0.025,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorConstant.primaryColor,
                                          padding: EdgeInsets.only(
                                            top: size.height * 0.02,
                                            bottom: size.height * 0.02,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                size.height * 0.01),
                                          ),
                                        ),
                                        onPressed: () {
                                          confirmPayBloc.eventController.sink
                                              .add(ClickPaymentEvent(
                                                  bookingInputBloc:
                                                      bookingInputBloc,
                                                  context: context));
                                        },
                                        child: Text("Đặt Lịch")))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  confirmPayBloc.isWaiting
                      ? Container(
                          height: size.height,
                          width: size.width,
                          color: Colors.black.withOpacity(0.5),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              );
            },
          )),
    );
  }
}
