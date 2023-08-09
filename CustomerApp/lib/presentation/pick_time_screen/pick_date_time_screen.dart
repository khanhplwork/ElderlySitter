import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/core/models/booking_models/add_booking_detail_dto.dart';
import 'package:elscus/core/models/booking_models/booking_form_data_model.dart';
import 'package:elscus/core/models/working_time_model/slot_data_model.dart';
import 'package:elscus/presentation/pick_time_screen/widget/date_item.dart';
import 'package:elscus/presentation/splash_screen/splash_screen.dart';
import 'package:elscus/process/bloc/booking_bloc.dart';
import 'package:elscus/process/event/booking_event.dart';
import 'package:elscus/process/state/booking_state.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../core/utils/globals.dart' as globals;

// ignore: must_be_immutable
class PickDateTimeScreen extends StatefulWidget {
  PickDateTimeScreen({
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
  State<PickDateTimeScreen> createState() => _PickDateTimeScreenState(
      elderID: elderID,
      packageServiceID: packageServiceID,
      totalPrice: totalPrice,
      duration: duration,
      packageName: packageName,
      elderName: elderName);
}

enum AddressType { cusAddress, custom }

class _PickDateTimeScreenState extends State<PickDateTimeScreen> {
  _PickDateTimeScreenState({
    required this.elderID,
    required this.packageServiceID,
    required this.totalPrice,
    required this.duration,
    required this.packageName,
    required this.elderName,
  });

  String elderID;
  String packageServiceID;
  double totalPrice;
  int duration;
  String packageName;
  String elderName;
  final _bookingBloc = BookingBloc();
  DateTime pickedDate = DateTime.now().add(Duration(days: 2));
  AddressType _addrType = AddressType.cusAddress;
  final addressController = TextEditingController();
  List<SlotDataModel> listSlot = [];
  SlotDataModel pickSlot = SlotDataModel(slots: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _bookingBloc.eventController.sink
    //     .add(ChooseDateOnlyBookingEvent(pickedDate: DateTime.now()));
    _bookingBloc.eventController.sink.add(AddEstimateTime(estimate: duration));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _bookingBloc.eventController.sink.add(GetAllSlotWorking());
    return StreamBuilder<BookingState>(
        stream: _bookingBloc.stateController.stream,
        initialData: LoadingDataState(),
        builder: (context, snapshot) {
          if (snapshot.data is HaveSlotWorkingState) {
            listSlot = (snapshot.data as HaveSlotWorkingState).listSlot;
            _bookingBloc.stateController.sink.add(OtherBookingState());
          }
          if (snapshot.data is LoadingDataState) {
            return SplashScreen();
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
                padding: EdgeInsets.only(left: size.width * 0.06),
                child: const Text(
                  "Chọn thời gian làm việc",
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
                color: ColorConstant.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.height * 0.03),
                  topRight: Radius.circular(size.height * 0.03),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${totalPrice.ceil().toString()} VNĐ/$duration giờ",
                    style: GoogleFonts.roboto(
                      fontSize: size.height * 0.022,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      print(
                          "ok ${DateFormat("yyyy-MM-dd").format(pickedDate)}");
                      List<AddBookingDetailDto> timeDtos = [];
                      BookingDataModel booking = BookingDataModel(
                          address: (_addrType == AddressType.custom)
                              ? addressController.text
                              : globals.cusDetailModel!.address,
                          place: "Tại Nhà",
                          startDate:
                              DateFormat("yyyy-MM-dd").format(pickedDate),
                          endDate: DateFormat("yyyy-MM-dd").format(pickedDate),
                          description: "",
                          elderId: elderID,
                          customerId: globals.customerID,
                          packageId: packageServiceID,
                          addBookingDetailDtos: timeDtos);
                      _bookingBloc.eventController.sink.add(AddTimeBookingEvent(
                          booking: booking,
                          context: context,
                          packageName: packageName,
                          elderName: elderName,
                          totalPrice: totalPrice));
                    },
                    child: Text(
                      "Tiếp theo",
                      style: GoogleFonts.roboto(
                        fontSize: size.height * 0.022,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: Material(
              child: Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Thời lượng
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.02,
                          left: size.width * 0.05,
                        ),
                        child: Text(
                          "Địa chỉ thực hiện",
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.024,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text('Địa chỉ mặc định của bạn'),
                        leading: Radio<AddressType>(
                          value: AddressType.cusAddress,
                          groupValue: _addrType,
                          onChanged: (AddressType? value) {
                            setState(() {
                              _addrType = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Thêm địa chỉ khác'),
                        leading: Radio<AddressType>(
                          value: AddressType.custom,
                          groupValue: _addrType,
                          onChanged: (AddressType? value) {
                            setState(() {
                              _addrType = value!;
                            });
                          },
                        ),
                      ),
                      (_addrType == AddressType.custom)
                          ? Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                                left: size.width * 0.07,
                                right: size.width * 0.07,
                              ),
                              child: TextField(
                                onChanged: (value) {},
                                style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black),
                                cursorColor: ColorConstant.primaryColor,
                                controller: addressController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: size.width * 0.03,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: GoogleFonts.roboto(
                                    color: Colors.black,
                                  ),
                                  labelText: 'Địa chỉ làm việc: ',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: ColorConstant.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),

                      //Thời gian làm việc
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.02,
                          left: size.width * 0.05,
                        ),
                        child: Text(
                          "Thời gian làm việc",
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.024,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.015,
                          left: size.width * 0.07,
                          right: size.width * 0.07,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Chọn ngày làm việc",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Tháng ${DateTime.now().month}/${DateTime.now().year}",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
//Lich gen
                      SizedBox(
                        height: size.height * 0.15,
                        child: ListView.separated(
                          padding: EdgeInsets.only(
                            left: size.width * 0.03,
                            top: size.height * 0.02,
                          ),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (index == 7) {
                              return Container(
                                width: size.width * 0.2,
                                height: size.height * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      size.height * 0.015),
                                ),
                                child: Image.asset(
                                  ImageConstant.icCalendar,
                                  width: size.width * 0.06,
                                  height: size.width * 0.06,
                                ),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pickedDate = DateTime.now()
                                        .add(Duration(days: index + 2));
                                    _bookingBloc.eventController.sink.add(
                                        ChooseDateOnlyBookingEvent(
                                            pickedDate: pickedDate));
                                  });
                                },
                                child: dateItem(
                                    context,
                                    DateTime.now()
                                        .add(Duration(days: index + 2)),
                                    pickedDate),
                              );
                            }
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            width: size.width * 0.02,
                          ),
                          itemCount: 8,
                        ),
                      ),
                      Container(
                        width: size.width,
                        margin: EdgeInsets.only(
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                          top: size.height * 0.015,
                        ),
                        padding: EdgeInsets.only(
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                          top: size.height * 0.01,
                          bottom: size.height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.greyWeekBox,
                          borderRadius:
                              BorderRadius.circular(size.height * 0.01),
                        ),
                        child: ListTile(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                barrierColor: Colors.transparent,
                                // backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                enableDrag: false,
                                builder: (builder) {
                                  return StatefulBuilder(
                                    builder: 
                                  (context,setStateModal) =>  Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        height: size.height * 0.4,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade50,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        child: GridView.count(
                                          scrollDirection: Axis.vertical,
                                          physics: const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          childAspectRatio: (1 / .4),
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 8.0,
                                          children: List.generate(
                                              _bookingBloc.listSlot.length,
                                              (index) {
                                            return GestureDetector(
                                              onTap: () {
                                                //jj
                                                // Navigator.pop(context);
                                                setStateModal(() {
                                                  setState(() {
                                                  pickSlot = listSlot[index];
                                                  });
                                                  _bookingBloc
                                                      .eventController.sink
                                                      .add(ChooseTimeOnlyBooking(
                                                          pickSlot));
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
                                                  color: (listSlot[index].slots ==
                                                          pickSlot.slots)
                                                      ? ColorConstant.primaryColor
                                                      : ColorConstant.primaryColor
                                                          .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          size.height * 0.03),
                                                ),
                                                child: FittedBox(
                                                  fit: BoxFit.cover,
                                                  child: Text(
                                                    _bookingBloc
                                                        .listSlot[index].slots
                                                        .split(' ')[1],
                                                    style: GoogleFonts.roboto(
                                                      color: (_bookingBloc
                                                              .listSlot
                                                              .contains(
                                                                  "${index + 1}"))
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight: FontWeight.w400,
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
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Chọn thời gian",
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: size.height * 0.03,
                                color: Colors.black87,
                              ),
                              Text(pickSlot.slots.isNotEmpty
                                  ? pickSlot.slots.split(" ")[1]
                                  : listSlot[0].slots.split(" ")[1]),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: size.width,
                        margin: EdgeInsets.only(
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                          top: size.height * 0.02,
                        ),
                        padding: EdgeInsets.only(
                          top: size.height * 0.012,
                          bottom: size.height * 0.012,
                          left: size.width * 0.03,
                          right: size.width * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: ColorConstant.greyElderBox,
                          ),
                          borderRadius:
                              BorderRadius.circular(size.height * 0.01),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 4.0,
                              offset: Offset(2.0, 4.0),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                            Text(
                              "  Những công việc có trong gói dịch vụ",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.015,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width,
                        margin: EdgeInsets.only(
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                          top: size.height * 0.02,
                        ),
                        padding: EdgeInsets.only(
                          top: size.height * 0.012,
                          bottom: size.height * 0.012,
                          left: size.width * 0.03,
                          right: size.width * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: ColorConstant.greyElderBox,
                          ),
                          borderRadius:
                              BorderRadius.circular(size.height * 0.01),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 4.0,
                              offset: Offset(2.0, 4.0),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cancel,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                            Text(
                              "  Những công việc không có trong gói dịch vụ",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.015,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
