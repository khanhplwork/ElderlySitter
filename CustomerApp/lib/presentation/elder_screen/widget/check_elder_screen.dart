import 'package:elscus/core/models/elder_models/elder_check_data_model.dart';
import 'package:elscus/presentation/elder_screen/widget/confirm_add_relation_dialog.dart';
import 'package:elscus/presentation/elder_screen/widget/customer_item.dart';
import 'package:elscus/process/bloc/elder_bloc.dart';
import 'package:elscus/process/event/elder_event.dart';
import 'package:elscus/process/state/elder_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_constant.dart';
import '../../../core/constants/image_constant.dart';

class CheckElderScreen extends StatefulWidget {
  const CheckElderScreen({Key? key, required this.idNumber}) : super(key: key);
  final String idNumber;

  @override
  State<CheckElderScreen> createState() =>
      // ignore: no_logic_in_create_state
      _CheckElderScreenState(idNumber: idNumber);
}

class _CheckElderScreenState extends State<CheckElderScreen> {
  _CheckElderScreenState({required this.idNumber});

  final String idNumber;
  final elderBloc = ElderBloc();
  ElderCheckDataModel? checkData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    elderBloc.eventController.sink
        .add(GetCheckDataElderEvent(idNumber: idNumber));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: elderBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is GetCheckDataElderState) {
              checkData =
                  (snapshot.data as GetCheckDataElderState).elderCheckData;
            }
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              bottomOpacity: 0,
              elevation: 0,
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
              title: Padding(
                padding: EdgeInsets.only(left: size.width * 0.12),
                child: Text(
                  "Kiểm Tra Thông Tin",
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.024,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
              width: size.width * 0.84,
              height: size.height * 0.055,
              child: ElevatedButton(
                onPressed: () {
                  showConfirmAddRelationDialog(context, elderBloc, checkData!.id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor,
                ),
                child: Text(
                  "Thêm Người Thân",
                  style: GoogleFonts.roboto(
                    fontSize: size.width * 0.045,
                  ),
                ),
              ),
            ),
            body: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: size.height * 0.03,
                          bottom: size.height * 0.03,
                        ),
                        padding: EdgeInsets.only(
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                          top: size.height * 0.015,
                          bottom: size.height * 0.015,
                        ),
                        decoration: BoxDecoration(color: Colors.white),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Đang có ${(checkData != null) ? checkData!.customerDtoList.length : '0'} người dùng đăng ký thân nhân này",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.018,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: size.height * 0.02,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      (checkData != null)
                          ? customerItem(context, checkData!.customerDtoList)
                          : const SizedBox(),
                      (checkData != null) ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05, vertical: size.height * 0.02),
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05, vertical: size.height * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Thân Nhân",
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.height * 0.022,
                                ),
                              ),
                            ),
                            SizedBox(height: size.height*0.02,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Họ và tên:",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      checkData!.fullName,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: size.height * 0.018,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height*0.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Giới tính:",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      checkData!.gender,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: size.height * 0.018,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height*0.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Ngày sinh:",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      checkData!.dob,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: size.height * 0.018,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height*0.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Tình trạng:  ",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      checkData!.healthStatus,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: size.height * 0.018,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ) : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
