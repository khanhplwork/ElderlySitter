import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elscus/core/models/elder_models/elder_detail_model.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/core/utils/math_lib.dart';
import 'package:elscus/core/utils/my_utils.dart';
import 'package:elscus/process/bloc/elder_bloc.dart';
import 'package:elscus/process/event/elder_event.dart';
import 'package:elscus/process/state/elder_state.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_constant.dart';

class ElderDetailScreen extends StatefulWidget {
  const ElderDetailScreen({Key? key, required this.elderID}) : super(key: key);
  final String elderID;

  @override
  // ignore: no_logic_in_create_state
  State<ElderDetailScreen> createState() =>
      // ignore: no_logic_in_create_state
      _ElderDetailScreenState(elderID: elderID);
}

class _ElderDetailScreenState extends State<ElderDetailScreen> {
  _ElderDetailScreenState({required this.elderID});

  final String elderID;
  final _elderBloc = ElderBloc();
  final List<String> genderItems = [
    'Nam',
    'Nữ',
    'Khác',
  ];
  final List<String> elderHealthStatusItems = [
    'Người cao tuổi tự đi đứng sinh hoạt',
    'Người cao tuổi cần sự hỗ trợ sinh hoạt',
    'Người cao tuổi không có khả năng sinh hoạt',
  ];
  late var fullNameController = TextEditingController();
  late var idNumberController = TextEditingController();
  String healthStatusStr = "Người cao tuổi tự đi đứng sinh hoạt";
  String genderStr = "Nam";
  DateTime selectedDate = DateTime.now();
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateInput.text = "";
    _elderBloc.eventController.sink
        .add(GetElderDetailDataEvent(elderID: elderID));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<ElderState>(
        stream: _elderBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is ElderDetailState) {
              ElderDetailModel elderDetail =
                  (snapshot.data as ElderDetailState).elder;
              _elderBloc.eventController.sink.add(
                  FillElderFullNameEvent(fullName: elderDetail.data.fullName));
              fullNameController =
                  TextEditingController(text: elderDetail.data.fullName);
              _elderBloc.eventController.sink.add(ChooseElderDOBEvent(
                  dob: MyUtils().revertYMD(
                      MathLib().convertInputElderDob(elderDetail.data.dob))));
              dateInput = TextEditingController(
                  text: MathLib()
                      .convertInputElderDob(elderDetail.data.dob)
                      .split("-")[2]);
              _elderBloc.eventController.sink.add(ChooseElderHeathStatusEvent(
                  healthStatus: elderDetail.data.healthStatus));
              healthStatusStr = elderDetail.data.healthStatus;
              _elderBloc.eventController.sink
                  .add(ChooseElderGenderEvent(gender: elderDetail.data.gender));
              genderStr = elderDetail.data.gender;
              _elderBloc.eventController.sink.add(FillIDCardNumberEvent(
                  idNumber: elderDetail.data.idCardNumber));
              idNumberController =
                  TextEditingController(text: elderDetail.data.idCardNumber);
              _elderBloc.eventController.sink.add(OtherElderEvent());
            }
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorConstant.primaryColor.withOpacity(0.2),
              bottomOpacity: 0.0,
              elevation: 0.0,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.delete_outline_outlined,
                    size: size.height * 0.03,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _elderBloc.eventController.sink.add(
                        DeleteElderEvent(elderID: elderID, context: context));
                  },
                ),
              ],
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_outlined,
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
              width: size.width * 0.84,
              height: size.height * 0.055,
              child: ElevatedButton(
                onPressed: () {
                  _elderBloc.eventController.sink.add(
                      UpdateElderEvent(elderID: elderID, context: context));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor,
                  textStyle: TextStyle(
                    fontSize: size.width * 0.045,
                  ),
                ),
                child: const Text("Xác nhận"),
              ),
            ),
            body: Material(
              child: Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  color: ColorConstant.primaryColor.withOpacity(0.2),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.8),
                      child: Image.asset(
                        ImageConstant.appIcon,
                        width: size.width * 0.25,
                        height: size.height * 0.15,
                      ),
                    ),
                    Container(
                      height: size.height * 0.75,
                      width: size.width,
                      padding: EdgeInsets.only(
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstant.greyAccBg,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                        ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.08,
                              ),
                              child: TextField(
                                onChanged: (value) {
                                  _elderBloc.eventController.sink.add(
                                      FillElderFullNameEvent(
                                          fullName: value.toString()));
                                },
                                style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black),
                                cursorColor: ColorConstant.primaryColor,
                                controller: fullNameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: size.width * 0.03,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: GoogleFonts.roboto(
                                    color: Colors.black,
                                  ),
                                  labelText: 'Họ và tên: ',
                                  errorText: (snapshot.hasError &&
                                          (snapshot.error
                                                  as Map<String, String>)
                                              .containsKey("fullName"))
                                      ? (snapshot.error
                                          as Map<String, String>)["fullName"]
                                      : null,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
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
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                              ),
                              child: TextField(
                                onChanged: (value) {
                                  _elderBloc.eventController.sink.add(
                                      FillIDCardNumberEvent(
                                          idNumber: value.toString()));
                                },
                                style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black),
                                cursorColor: ColorConstant.primaryColor,
                                controller: idNumberController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: size.width * 0.03,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: GoogleFonts.roboto(
                                    color: Colors.black,
                                  ),
                                  labelText: 'CCCD/CMND: ',
                                  errorText: (snapshot.hasError &&
                                          (snapshot.error
                                                  as Map<String, String>)
                                              .containsKey("idNumber"))
                                      ? (snapshot.error
                                          as Map<String, String>)["idNumber"]
                                      : null,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
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
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                              ),
                              child: Stack(
                                alignment: AlignmentDirectional.centerEnd,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: SizedBox(
                                              // Need to use container to add size constraint.
                                              width: size.width,
                                              height: size.height * 0.5,
                                              child: YearPicker(
                                                firstDate: DateTime(
                                                    DateTime.now().year - 100,
                                                    1),
                                                lastDate: DateTime(
                                                    DateTime.now().year - 60,
                                                    1),
                                                initialDate: DateTime.now(),
                                                // save the selected date to _selectedDate DateTime variable.
                                                // It's used to set the previous selected date when
                                                // re-showing the dialog.
                                                selectedDate: selectedDate,
                                                onChanged: (DateTime dateTime) {
                                                  // close the dialog when year is selected.
                                                  setState(() {
                                                    selectedDate = dateTime;
                                                    _elderBloc
                                                        .eventController.sink
                                                        .add(ChooseElderDOBEvent(
                                                            dob:
                                                                "${dateTime.year}-01-01"));

                                                    dateInput =
                                                        TextEditingController(
                                                            text:
                                                                "${dateTime.year}");
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: TextField(
                                      style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          color: Colors.black),
                                      cursorColor: ColorConstant.primaryColor,
                                      controller: dateInput,
                                      enabled: false,
                                      // onChanged: (value){
                                      //   _elderBloc.eventController.sink.add(
                                      //       ChooseElderDOBEvent(
                                      //           dob: value.toString().trim()));
                                      // },

                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: size.width * 0.03,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        labelStyle: GoogleFonts.roboto(
                                          color: Colors.black,
                                        ),
                                        labelText: 'Năm sinh: ',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: ColorConstant.primaryColor,
                                          ),
                                        ),
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              right: size.width * 0.03),
                                          child: ImageIcon(
                                            AssetImage(
                                              ImageConstant.icCalendar,
                                            ),
                                            color: ColorConstant.primaryColor,
                                          ),
                                        ),
                                        suffixIconConstraints: BoxConstraints(
                                            minHeight: size.width * 0.06,
                                            minWidth: size.width * 0.06),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            (snapshot.hasError &&
                                    (snapshot.error as Map<String, String>)
                                        .containsKey("dob"))
                                ? SizedBox(
                                    width: size.width,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.03,
                                      ),
                                      child: Text(
                                        (snapshot.error
                                            as Map<String, String>)["dob"]!,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: ColorConstant.redErrorText,
                                          fontSize: size.height * 0.016,
                                          height: 0.01,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                              ),
                              child: DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: size.width * 0.03,
                                    right: size.width * 0.03,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: GoogleFonts.roboto(
                                    color: Colors.black,
                                  ),
                                  labelText: 'Giới tính: ',
                                  errorText: (snapshot.hasError &&
                                          (snapshot.error
                                                  as Map<String, String>)
                                              .containsKey("gender"))
                                      ? (snapshot.error
                                          as Map<String, String>)["gender"]
                                      : null,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: ColorConstant.primaryColor,
                                    ),
                                  ),
                                ),
                                hint: const Text(
                                  'Chọn giới tính',
                                  style: TextStyle(fontSize: 14),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.grey,
                                ),
                                iconSize: size.width * 0.06,
                                buttonHeight: size.height * 0.07,
                                buttonPadding: const EdgeInsets.all(0),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                value: genderStr,
                                items: genderItems
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: GoogleFonts.roboto(
                                            fontSize: size.height * 0.022,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  _elderBloc.eventController.sink.add(
                                      ChooseElderGenderEvent(
                                          gender: value.toString()));
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                              ),
                              child: DropdownButtonFormField2(
                                style: GoogleFonts.roboto(
                                    fontSize: size.height * 0.022,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: size.width * 0.03,
                                    right: size.width * 0.03,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: GoogleFonts.roboto(
                                    color: Colors.black,
                                  ),
                                  labelText: 'Tình trạng sức khỏe: ',
                                  errorText: (snapshot.hasError &&
                                          (snapshot.error
                                                  as Map<String, String>)
                                              .containsKey("healthStatus"))
                                      ? (snapshot.error as Map<String, String>)[
                                          "healthStatus"]
                                      : null,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: ColorConstant.primaryColor,
                                    ),
                                  ),
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  'Chọn tình trạng',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.grey,
                                ),
                                iconSize: size.width * 0.06,
                                buttonHeight: size.height * 0.07,
                                buttonPadding: const EdgeInsets.all(0),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                value: healthStatusStr,
                                items: elderHealthStatusItems
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          maxLines: null,
                                          style: GoogleFonts.roboto(
                                            fontSize: size.height * 0.02,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  _elderBloc.eventController.sink.add(
                                      ChooseElderHeathStatusEvent(
                                          healthStatus: value.toString()));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: size.height * 0.72,
                      ),
                      child: SizedBox(
                        width: size.width * 0.84,
                        height: size.height * 0.055,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ColorConstant.primaryColor.withOpacity(0.7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            textStyle: TextStyle(
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          child: const Text("Thông tin người thân"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
