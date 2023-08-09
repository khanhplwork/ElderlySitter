import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/core/models/cus_models/cus_detail_data_model.dart';
import 'package:elscus/core/utils/math_lib.dart';
import 'package:elscus/presentation/search_address_screen/search_address_screen.dart';
import 'package:elscus/process/bloc/address_bloc.dart';
import 'package:elscus/process/bloc/cus_bloc.dart';
import 'package:elscus/process/event/cus_event.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/utils/globals.dart' as globals;
import '../../process/state/cus_state.dart';

class PersonalDetailScreen extends StatefulWidget {
  const PersonalDetailScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDetailScreen> createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<PersonalDetailScreen> {
  final _cusBloc = CusBloc();
  final addressBloc = AddressBloc();
  final List<String> genderItems = [
    'Nam',
    'Nữ',
    'Khác',
  ];
  String genderValue = "";
  late var fullnameController = TextEditingController();
  late var emailController = TextEditingController();
  late var phoneNumberController = TextEditingController();
  late var idNumberController = TextEditingController();
  late var addressController = TextEditingController();
  String avatarImage = "";
  late File imageFileAvatar;
  XFile? pickedFileAvatar;
  UploadTask? uploadTaskAvatar;
  bool _isAddAvatar = false;
  bool _isNetworkAva = false;

  _getAvatarImageFromGallery() async {
    pickedFileAvatar = (await ImagePicker().pickImage(
      source: ImageSource.camera,
    ));
    if (pickedFileAvatar != null) {
      setState(() {
        imageFileAvatar = File(pickedFileAvatar!.path);
      });
    }
    _isAddAvatar = true;
    final path = 'els_cus_images/${pickedFileAvatar!.name}';
    final file = File(pickedFileAvatar!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTaskAvatar = ref.putFile(file);

    final snapshot = await uploadTaskAvatar!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    avatarImage = urlDownload;
    _cusBloc.eventController.sink
        .add(ChooseAvaImageCusEvent(avaUrl: avatarImage));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController =
        TextEditingController(text: globals.cusDetailModel!.email);
    _cusBloc.eventController.sink.add(GetInfoCusEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.greyAccBg,
        bottomOpacity: 0.0,
        elevation: 0.0,
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
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width * 0.05,
        ),
        decoration: BoxDecoration(
          color: ColorConstant.greyAccBg,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: StreamBuilder<Object>(
              stream: _cusBloc.stateController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data is CusDetailState) {
                    CusDetailDataModel cusInfo =
                        (snapshot.data as CusDetailState).cusInfo;
                    if (cusInfo.avatarImgUrl.isNotEmpty) {
                      _isNetworkAva = true;
                      avatarImage = cusInfo.avatarImgUrl;
                      _cusBloc.eventController.sink.add(
                          ChooseAvaImageCusEvent(avaUrl: cusInfo.avatarImgUrl));
                    }
                    addressController.text=cusInfo.address;
                    _cusBloc.eventController.sink
                        .add(FillFullnameCusEvent(fullname: cusInfo.fullName));
                    fullnameController =
                        TextEditingController(text: cusInfo.fullName);
                    _cusBloc.eventController.sink.add(
                        FillPhoneNumberCusEvent(phoneNumber: cusInfo.phone));
                    phoneNumberController =
                        TextEditingController(text: cusInfo.phone);
                    if (cusInfo.idCardNumber.isNotEmpty) {
                      _cusBloc.eventController.sink.add(
                          FillIDNumberCusEvent(idNumber: cusInfo.idCardNumber));
                      idNumberController =
                          TextEditingController(text: cusInfo.idCardNumber);
                    }

                    if (cusInfo.gender.isNotEmpty) {
                      _cusBloc.eventController.sink
                          .add(ChooseGenderCusEvent(gender: cusInfo.gender));
                      genderValue = cusInfo.gender;
                    }
                    if (cusInfo.dob.isNotEmpty) {
                      _cusBloc.eventController.sink.add(ChooseDobCusEvent(
                          dob: MathLib().convertInputElderDob(cusInfo.dob)));
                    }
                    _cusBloc.lat = cusInfo.latitude;
                    _cusBloc.lng = cusInfo.longitude;
                  }
                  if (snapshot.data is UpdateAddressState) {
                    addressController =
                        TextEditingController(text: _cusBloc.address);
                  }
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    avatarWidget(context),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.08,
                      ),
                      child: TextField(
                        onChanged: (value) {
                          _cusBloc.eventController.sink.add(
                              FillFullnameCusEvent(fullname: value.toString()));
                        },
                        style: TextStyle(
                            fontSize: size.width * 0.04, color: Colors.black),
                        cursorColor: ColorConstant.primaryColor,
                        controller: fullnameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: size.width * 0.03,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: GoogleFonts.roboto(
                            color: Colors.black,
                          ),
                          labelText: 'Họ và tên*',
                          errorText: (snapshot.hasError &&
                                  (snapshot.error as Map<String, String>)
                                      .containsKey("fullname"))
                              ? (snapshot.error
                                  as Map<String, String>)["fullname"]
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
                        style: TextStyle(
                            fontSize: size.width * 0.04, color: Colors.black),
                        cursorColor: ColorConstant.primaryColor,
                        controller: emailController,
                        enabled: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: size.width * 0.03,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: GoogleFonts.roboto(
                            color: Colors.black,
                          ),
                          labelText: 'Email*',
                          errorText: null,
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
                          _cusBloc.eventController.sink.add(
                              FillPhoneNumberCusEvent(
                                  phoneNumber: value.toString()));
                        },
                        style: TextStyle(
                            fontSize: size.width * 0.04, color: Colors.black),
                        cursorColor: ColorConstant.primaryColor,
                        // controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: size.width * 0.03,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: GoogleFonts.roboto(
                            color: Colors.black,
                          ),
                          labelText: 'Số điện thoại*',
                          errorText: (snapshot.hasError &&
                                  (snapshot.error as Map<String, String>)
                                      .containsKey("phoneNumber"))
                              ? (snapshot.error
                                  as Map<String, String>)["phoneNumber"]
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
                          _cusBloc.eventController.sink.add(
                              FillIDNumberCusEvent(idNumber: value.toString()));
                        },
                        style: TextStyle(
                            fontSize: size.width * 0.04, color: Colors.black),
                        cursorColor: ColorConstant.primaryColor,
                        // controller: idNumberController,
                        keyboardType: TextInputType.number,
                        controller: idNumberController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: size.width * 0.03,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: GoogleFonts.roboto(
                            color: Colors.black,
                          ),
                          labelText: 'Số CMND/CCCD*',
                          errorText: (snapshot.hasError &&
                                  (snapshot.error as Map<String, String>)
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
                          labelText: 'Giới tính*',
                          errorText: (snapshot.hasError &&
                                  (snapshot.error as Map<String, String>)
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
                        value: (genderValue.isEmpty) ? null : genderValue,
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
                        // value: genderStr,
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
                          _cusBloc.eventController.sink.add(
                              ChooseGenderCusEvent(gender: value.toString()));
                        },
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
                              DatePicker.showDatePicker(context,
                                  //showDateTime to pick time
                                  showTitleActions: true,
                                  minTime: DateTime(1950, 1, 1),
                                  maxTime: DateTime.now(),
                                  onChanged: (date) {}, onConfirm: (date) {
                                String dateInput =
                                    '${(date.day >= 10) ? date.day : '0${date.day}'}-${(date.month >= 10) ? date.month : '0${date.month}'}-${date.year}';
                                _cusBloc.eventController.sink
                                    .add(ChooseDobCusEvent(dob: dateInput));
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.vi);
                            },
                            child: TextField(
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  color: Colors.black),
                              cursorColor: ColorConstant.primaryColor,
                              controller: (snapshot.data is CusDobState)
                                  ? (snapshot.data as CusDobState).dobController
                                  : null,
                              enabled: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: size.width * 0.03,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelStyle: GoogleFonts.roboto(
                                  color: Colors.black,
                                ),
                                labelText: 'Ngày sinh*',
                                errorText: (snapshot.hasError &&
                                        (snapshot.error as Map<String, String>)
                                            .containsKey("dob"))
                                    ? (snapshot.error
                                        as Map<String, String>)["dob"]
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
                                suffixIcon: Padding(
                                  padding:
                                      EdgeInsets.only(right: size.width * 0.03),
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
                                (snapshot.error as Map<String, String>)["dob"]!,
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
                        child: Container(
                          margin: EdgeInsets.only(
                            bottom: size.height * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.whiteE3,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SearchAddressPage(cusBloc: _cusBloc),
                                  ));
                            },
                            child: TextField(
                              enabled: false,
                              onChanged: (value) {},
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),

                              cursorColor: ColorConstant.primaryColor,
                              controller: addressController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Địa chỉ hiện tại",
                                labelText: "Địa chỉ*",
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
                                suffixIcon: Padding(
                                  padding:
                                  EdgeInsets.only(right: size.width * 0.03),
                                  child: Icon(Icons.location_on, size: size.height*0.03, color: ColorConstant.primaryColor,)
                                ),
                                suffixIconConstraints: BoxConstraints(
                                    minHeight: size.width * 0.06,
                                    minWidth: size.width * 0.06),
                              ),
                            ),
                          ),
                        )

                        //  TextField(
                        //   onChanged: (value) {
                        //     _cusBloc.eventController.sink.add(
                        //         FillAddressCusEvent(address: "${value.toString().trim()}, $wardValue, $districtValue, $provinceValue"));
                        //   },
                        //   style: TextStyle(
                        //       fontSize: size.width * 0.04, color: Colors.black),
                        //   cursorColor: ColorConstant.primaryColor,
                        //   controller: addressController,
                        //   decoration: InputDecoration(
                        //     contentPadding: EdgeInsets.only(
                        //       left: size.width * 0.03,
                        //     ),
                        //     filled: true,
                        //     fillColor: Colors.white,
                        //     labelStyle: GoogleFonts.roboto(
                        //       color: Colors.black,
                        //     ),
                        //     labelText: 'Số nhà - Tên đường*',
                        //     errorText: (snapshot.hasError &&
                        //             (snapshot.error as Map<String, String>)
                        //                 .containsKey("address"))
                        //         ? (snapshot.error
                        //             as Map<String, String>)["address"]
                        //         : null,
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //       borderSide: const BorderSide(
                        //         width: 0,
                        //         style: BorderStyle.none,
                        //       ),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         width: 1,
                        //         color: ColorConstant.primaryColor,
                        //       ),
                        //     ),

                        //   ),
                        // ),
                        ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.08,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: size.height * 0.055,
                        child: ElevatedButton(
                          onPressed: () {
                            _cusBloc.eventController.sink
                                .add(UpdateInfoCusEvent(context: context));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.primaryColor,
                            textStyle: TextStyle(
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          child: const Text("Cập nhật thông tin"),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget avatarWidget(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (_isAddAvatar) {
      return Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.03,
        ),
        child: Container(
          height: size.height * 0.12,
          width: size.height * 0.12,
          decoration: BoxDecoration(
            color: ColorConstant.primaryColor.withOpacity(0.2),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: FileImage(imageFileAvatar),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.08,
                    left: size.height * 0.08,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _getAvatarImageFromGallery();
                    },
                    child: Image.asset(
                      ImageConstant.icEditAvator,
                      width: size.width * 0.08,
                      height: size.width * 0.08,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      if (_isNetworkAva) {
        return Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.03,
          ),
          child: Container(
            height: size.height * 0.12,
            width: size.height * 0.12,
            decoration: BoxDecoration(
              color: ColorConstant.primaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(avatarImage),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.08,
                      left: size.height * 0.08,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _getAvatarImageFromGallery();
                      },
                      child: Image.asset(
                        ImageConstant.icEditAvator,
                        width: size.width * 0.08,
                        height: size.width * 0.08,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.03,
          ),
          child: Container(
            height: size.height * 0.12,
            width: size.height * 0.12,
            decoration: BoxDecoration(
              color: ColorConstant.primaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(ImageConstant.icPersonalDetail),
                fit: BoxFit.scaleDown,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.08,
                      left: size.height * 0.08,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _getAvatarImageFromGallery();
                      },
                      child: Image.asset(
                        ImageConstant.icEditAvator,
                        width: size.width * 0.08,
                        height: size.width * 0.08,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }
}
