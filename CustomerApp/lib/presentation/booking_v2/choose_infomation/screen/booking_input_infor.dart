import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/core/models/booking_models/add_booking_detail_dto.dart';
import 'package:elscus/core/models/booking_models/booking_form_data_model.dart';
import 'package:elscus/core/models/working_time_model/slot_data_model.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/model/elder_model_v2.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/bloc/booking_input_infor_bloc.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/bloc/booking_input_infor_event.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/bloc/booking_input_infor_state.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/model/data_search_model.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/screen/booking_pick_address.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/screen/booking_pick_time.dart';
import 'package:elscus/presentation/booking_v2/choose_package/model/package_model_v2.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/screen/confirm_pay_screen_increase.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/screen/widget/confirm_pay_screen.dart';
import 'package:elscus/presentation/pick_time_screen/widget/week_item.dart';
import 'package:elscus/presentation/splash_screen/splash_screen.dart';
import 'package:elscus/process/bloc/booking_bloc.dart';
import 'package:elscus/process/bloc/elder_bloc.dart';
import 'package:elscus/process/event/booking_event.dart';
import 'package:elscus/process/state/booking_state.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:talkjs_flutter/talkjs_flutter.dart';
import '../../../../core/utils/globals.dart' as globals;
import 'package:money_formatter/money_formatter.dart';

import '../widget/form_field_widget.dart';

// ignore: must_be_immutable
class BookingInputScreen extends StatefulWidget {
  BookingInputScreen(
      {Key? key,
      required this.package,
      required this.elder,
      this.isLockUpdate = false,
      this.addressTile = "Địa chỉ",
      this.slotTitle = "Thời gian bắt đầu",
      this.dateTitle = "Khoảng thời gian",
      this.bookingID = "",
      this.datesPostUp = const []})
      : super(key: key);
  PackageModelV2 package;
  ElderModelV2 elder;
  final String bookingID;
  final isLockUpdate;
  final String addressTile;
  final String slotTitle;
  final String dateTitle;
  final List<String> datesPostUp;

  @override
  // ignore: no_logic_in_create_state
  State<BookingInputScreen> createState() => _BookingInputScreenState(
      package: package,
      elder: elder,
      isLockUpdate: isLockUpdate,
      addressTile: addressTile,
      slotTitle: slotTitle,
      dateTitle: dateTitle,
      datesPostUp: datesPostUp,
      bookingID: bookingID);
}

enum AddressType { cusAddress, custom }

class _BookingInputScreenState extends State<BookingInputScreen> {
  _BookingInputScreenState(
      {required this.package,
      required this.elder,
      required this.isLockUpdate,
      this.addressTile = "",
      this.slotTitle = "",
      this.dateTitle = "",
      required this.datesPostUp,
      this.bookingID = ""});

  final List<String> datesPostUp;
  final String bookingID;
  final PackageModelV2 package;
  ElderModelV2 elder;
  final BookingInputInforBloc bookingInputBloc = BookingInputInforBloc();
  List<DateTime?>? dates = [];
  final isLockUpdate;
  String addressTile;
  String slotTitle;
  String dateTitle;

  @override
  void initState() {
    super.initState();
    print("kok" + dateTitle);

    bookingInputBloc.elder = elder;
    bookingInputBloc.package = package;
    bookingInputBloc.eventController.add(FetchSlotDataEvent());
    if (isLockUpdate) {
      bookingInputBloc.slotPicked = SlotDataModel(slots: slotTitle);
      bookingInputBloc.modelSearch = DataSearchModel(
          description: "",
          placeId: "",
          reference: "",
          structuredFormatting: StructuredFormatting(
              mainText: addressTile.split(",")[0], secondaryText: addressTile),
          compound: Compound(district: "", commune: "", province: ""),
          types: []);
      bookingInputBloc.titleAddress = addressTile;
      bookingInputBloc.titleDate = dateTitle;
      bookingInputBloc.titleSlot = slotTitle;
    } else {
       bookingInputBloc.setDefaultAddress();
      addressTile = globals.cusDetailModel!.address.isNotEmpty
          ? globals.cusDetailModel!.address
          : "Địa chỉ";
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("ELS"),
        backgroundColor: ColorConstant.primaryColor,
        centerTitle: true,
      ),
      body: StreamBuilder<Object>(
          stream: bookingInputBloc.stateController.stream,
          builder: (context, snapshot) {
            if (snapshot.data is OtherBookingInputInforState) {
              print("ok");
            }
            if (snapshot.data is LoadingInitBookingInputState) {
              return CircularProgressIndicator(
                color: ColorConstant.primaryColor,
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      if (!isLockUpdate) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingPickAddressScreen(
                                bookingInputBloc: bookingInputBloc,
                              ),
                            ));
                      }
                    },
                    title: Text("Địa điểm",
                        style: TextStyle(
                            color: ColorConstant.primaryColor,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1)),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: ColorConstant.primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                  bookingInputBloc.titleAddress != ""
                                      ? bookingInputBloc.titleAddress
                                      : "Địa chỉ",
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        Divider(
                          height: 3,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      // var results = await showCalendarDatePicker2Dialog(
                      //   barrierDismissible: false,
                      //   context: context,
                      //   config: CalendarDatePicker2WithActionButtonsConfig(
                      //     weekdayLabels: ["CN","T2","T3","T4","T5","T6","T7"],
                      //     selectedDayHighlightColor: ColorConstant.primaryColor,
                      //       centerAlignModePicker: true,
                      //       firstDate: DateTime.now(),
                      //       lastDate: DateTime.now().add(Duration(days: 30)),
                      //       calendarType: CalendarDatePicker2Type.multi),
                      //   dialogSize: const Size(325, 400),
                      //   value: dates??[],
                      //   borderRadius: BorderRadius.circular(15),
                      // );
                      // setState(() {
                      //   dates=results;
                      // });
                      if (!isLockUpdate) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingPickTimeScreen(
                                bookingInputBloc: bookingInputBloc,
                              ),
                            ));
                      }
                    },
                    title: Text("Ngày",
                        style: TextStyle(
                            color: ColorConstant.primaryColor,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1)),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              color: ColorConstant.primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(bookingInputBloc.titleDate != ""
                                ? bookingInputBloc.titleDate
                                : "Ngày"),
                          ],
                        ),
                        Divider(
                          height: 3,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      {
                        if (!isLockUpdate) {
                          showModalBottomSheet(
                              context: context,
                              barrierColor: Colors.transparent,
                              // backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              enableDrag: false,
                              builder: (builder) {
                                return StatefulBuilder(
                                  builder: (context, setStateModal) =>
                                      Container(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                          height: size.height * 0.4,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade50,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),
                                          child: GridView.count(
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            childAspectRatio: (1 / .4),
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 4.0,
                                            mainAxisSpacing: 8.0,
                                            children: List.generate(
                                                bookingInputBloc
                                                    .listSlot.length, (index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  //jj
                                                  // Navigator.pop(context);
                                                  setStateModal(() {
                                                    bookingInputBloc
                                                        .eventController.sink
                                                        .add(PickSlotEvent(
                                                            slotPicked:
                                                                bookingInputBloc
                                                                        .listSlot[
                                                                    index]));
                                                  });
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.only(
                                                    left: size.width * 0.05,
                                                    right: size.width * 0.05,
                                                    top: size.height * 0.01,
                                                    bottom: size.height * 0.01,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: (bookingInputBloc
                                                                .listSlot[index]
                                                                .slots ==
                                                            bookingInputBloc
                                                                .slotPicked
                                                                .slots)
                                                        ? ColorConstant
                                                            .primaryColor
                                                        : ColorConstant
                                                            .primaryColor
                                                            .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            size.height * 0.03),
                                                  ),
                                                  child: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: Text(
                                                      bookingInputBloc
                                                          .listSlot[index].slots
                                                          .split(' ')[1]
                                                          .split("-")[0],
                                                      style: GoogleFonts.roboto(
                                                        color: (bookingInputBloc
                                                                .listSlot
                                                                .contains(
                                                                    "${index + 1}"))
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize:
                                                            size.height * 0.018,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          )),
                                );
                              });
                        }
                      }
                    },
                    title: Text("Thời gian bắt đầu",
                        style: TextStyle(
                            color: ColorConstant.primaryColor,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1)),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              color: ColorConstant.primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(bookingInputBloc.titleSlot != ""
                                ? bookingInputBloc.titleSlot.split("-")[0]
                                : "Thời gian bắt đầu"),
                          ],
                        ),
                        Divider(
                          height: 3,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.03,
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                    ),
                    child: TextFormField(
                      maxLines: 3,
                      controller: bookingInputBloc.textController,
                      onChanged: (value) {
                        bookingInputBloc.setStringDescription(value.toString());
                      },
                      decoration: InputDecoration(
                        // errorText: bookingInputBloc.errorMessage,
                        labelText: "Ghi chú",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.4), width: 1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.height * 0.005))),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Tên gói:",
                            style: GoogleFonts.roboto(
                              color: ColorConstant.grey600,
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "${package.name}",
                            style: GoogleFonts.roboto(
                              color: ColorConstant.grey600,
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Giá gói:",
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
                            "${MoneyFormatter(amount: package.price!).output.withoutFractionDigits} VNĐ",
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
                  bookingInputBloc.isCheckedPrice
                      ? Column(
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Số ngày:",
                                      style: GoogleFonts.roboto(
                                        color: ColorConstant.grey600,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  Text(
                                      !isLockUpdate
                                          ? bookingInputBloc.isMultiChoose
                                              ? "${bookingInputBloc.dates.length} ngày"
                                              : "${bookingInputBloc.dates.last!.difference(bookingInputBloc.dates.first!).inDays + 1} ngày"
                                          : "${datesPostUp.length}",
                                      style: GoogleFonts.roboto(
                                        color: ColorConstant.grey600,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w500,
                                      ))
                                ],
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
                                              // ${bookingInputBloc.checkPriceModel!.datePriceInform.midnight!.date} ngày
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
                                                "Ngày bình thường:",
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
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Giá tạm tính:",
                                      style: GoogleFonts.roboto(
                                        color: ColorConstant.grey600,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  Text(
                                      "${MoneyFormatter(amount: bookingInputBloc.checkPriceModel!.totalPrice).output.withoutFractionDigits} VNĐ",
                                      style: GoogleFonts.roboto(
                                        color: ColorConstant.grey600,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w500,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info,
                          size: size.height * 0.03,
                          color: ColorConstant.primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Text(
                            "Giá tạm tính có thể cao hơn vào ngày cuối tuần và ngày lễ",
                            maxLines: 2,
                            style: GoogleFonts.roboto(
                              fontSize: size.height * 0.015,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  bookingInputBloc.isCheckedPrice
                      ? Container(
                          width: size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.2),
                          child: ElevatedButton(
                            onPressed: () {
                              if (!isLockUpdate) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ConfirmPayScreen(
                                          bookingInputBloc: bookingInputBloc),
                                    ));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ConfirmPayIncrease(
                                          bookingInputBloc: bookingInputBloc,
                                          bookingID: bookingID),
                                    ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  bookingInputBloc.isEnableCheckPriceButton
                                      ? ColorConstant.primaryColor
                                      : Colors.grey,
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                                bottom: size.height * 0.02,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.01),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Tiến hành thanh toán",
                                  style: GoogleFonts.roboto(
                                    fontSize: size.height * 0.022,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          width: size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.2),
                          child: ElevatedButton(
                            onPressed: () {
                              if (!isLockUpdate) {
                                print("ok");
                                bookingInputBloc.eventController.sink
                                    .add(ClickCheckPrice());
                              } else {
                                print("hêh");
                                bookingInputBloc.eventController.sink.add(
                                    ClickCheckPrice(
                                        dateUpdate: datesPostUp,
                                        startTime: slotTitle.split("-")[0],
                                        isUpdate: true));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  bookingInputBloc.isEnableCheckPriceButton
                                      ? ColorConstant.primaryColor
                                      : Colors.grey,
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                                bottom: size.height * 0.02,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.01),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                (snapshot.data is WaitingCheckPriceState)
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        "Kiểm tra giá",
                                        style: GoogleFonts.roboto(
                                          fontSize: size.height * 0.022,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        )
                ],
              ),
            );
          }),
    );
  }
//    Future<void> _navigateAndDisplaySelection() async {
//   // Navigator.push returns a Future that completes after calling
//   // Navigator.pop on the Selection Screen.
//   final result = await Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => BookingPickTimeScreen(bookingInputBloc: bookingInputBloc,)),
//   );

//   // When a BuildContext is used from a StatefulWidget, the mounted property
//   // must be checked after an asynchronous gap.
//   if (!mounted) return;

//   // After the Selection Screen returns a result, hide any previous snackbars
//   // and show the new result.
//  bookingInputBloc.eventController.add(UpdateEvent());
// }
}
