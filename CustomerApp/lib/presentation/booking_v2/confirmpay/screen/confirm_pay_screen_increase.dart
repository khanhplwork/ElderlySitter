import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/bloc/booking_input_infor_bloc.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/bloc/confirm_pay_bloc.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/bloc/confirm_pay_event.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/bloc/confirm_pay_state.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/screen/widget/fail_pay_screen.dart';
import 'package:elscus/presentation/success_screen/success_screen.dart';
import 'package:elscus/presentation/widget/dialog/fail_dialog.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_formatter/money_formatter.dart';

class ConfirmPayIncrease extends StatefulWidget {
  ConfirmPayIncrease(
      {super.key, required this.bookingInputBloc, required this.bookingID});

  final String bookingID;
  BookingInputInforBloc bookingInputBloc;

  @override
  State<ConfirmPayIncrease> createState() => _ConfirmPayIncreaseState(
      bookingInputBloc: bookingInputBloc, bookingID: bookingID);
}

enum SingingCharacter { lafayette, jefferson }

class _ConfirmPayIncreaseState extends State<ConfirmPayIncrease> {
  _ConfirmPayIncreaseState(
      {required this.bookingInputBloc, required this.bookingID});

  final String bookingID;
  BookingInputInforBloc bookingInputBloc;
  final confirmPayBloc = ConfirmPayBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    confirmPayBloc.eventController.sink.add(FetchDataWalletEvent());
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
                              subtitle: Text(bookingInputBloc.modelSearch!
                                  .structuredFormatting.secondaryText),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Đơn hàng của bạn",
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
                                      textAlign: TextAlign.left,
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
                                      bookingInputBloc.slotPicked.slots
                                          .split("-")[0],
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
                                      "Giá tạm tính:",
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
                      height: size.height * 0.13,
                      width: size.width,
                      // width:double.infinity,
                      color: Colors.blueGrey,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.payment_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Ví",
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: IconButton(
                                            onPressed: () {
                                              SingingCharacter? _character =
                                                  SingingCharacter.lafayette;
                                              showModalBottomSheet(
                                                  context: context,
                                                  barrierColor:
                                                      Colors.transparent,
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
                                                              height: size.height *
                                                                  0.4,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade50,
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft:
                                                                          Radius.circular(20),
                                                                      topRight: Radius.circular(20))),
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "Phương thức thanh toán",
                                                                    style: GoogleFonts
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
                                                                    leading: Icon(
                                                                        Icons
                                                                            .wallet),
                                                                    title: Text(
                                                                        "Ví"),
                                                                    trailing:
                                                                        Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: ColorConstant
                                                                          .primaryColor,
                                                                    ),
                                                                  ),
                                                                  ListTile(
                                                                    leading: Icon(
                                                                        Icons
                                                                            .wallet),
                                                                    title: Text(
                                                                        "MOMO"),
                                                                    //  trailing: Icon(Icons.check),
                                                                  )
                                                                ],
                                                              )),
                                                    );
                                                  });
                                            },
                                            icon:
                                                Icon(Icons.keyboard_arrow_up)))
                                  ],
                                ),
                                Container(
                                  color: Colors.white,
                                  height: size.height * 0.03,
                                  width: 3,
                                ),
                                Text(
                                  "Thêm coupon",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 3,
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
                                          "${MoneyFormatter(amount: bookingInputBloc.checkPriceModel!.totalPrice).output.withoutFractionDigits} VNĐ",
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
                                              .add(ClickPaymentIncreseEvent(
                                                  bookingInputBloc:
                                                      bookingInputBloc,
                                                  bookingID: bookingID,
                                                  context: context));
                                        },
                                        child: Text("Đặt lịch")))
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
