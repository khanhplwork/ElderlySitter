import 'package:elscus/process/event/report_event.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_constant.dart';
import '../../../core/utils/my_enum.dart';
import '../../../process/bloc/report_bloc.dart';

StatefulWidget reportContentWidget(
    BuildContext context,
    String title,
    ReportBloc reportBloc,
    AttitudeType attitudeType,
    SitterInfoType sitterInfoType) {
  var size = MediaQuery.of(context).size;
  if (title == 'Thái độ của chăm sóc viên') {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          width: size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text('Trễ giờ'),
                leading: Radio<AttitudeType>(
                  value: AttitudeType.late,
                  groupValue: attitudeType,
                  onChanged: (AttitudeType? value) {
                    setState(() {
                      reportBloc.eventController.sink.add(
                          ChooseAttitudeContentReportEvent(
                              content: "Trễ giờ", attitudeType: value!));
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Không thân thiện'),
                leading: Radio<AttitudeType>(
                  value: AttitudeType.unFriendly,
                  groupValue: attitudeType,
                  onChanged: (AttitudeType? value) {
                    setState(() {
                      reportBloc.eventController.sink.add(
                          ChooseAttitudeContentReportEvent(
                              content: "Không thân thiện",
                              attitudeType: value!));
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Khác'),
                leading: Radio<AttitudeType>(
                  value: AttitudeType.other,
                  groupValue: attitudeType,
                  onChanged: (AttitudeType? value) {
                    setState(() {
                      reportBloc.eventController.sink.add(
                          ChooseAttitudeContentReportEvent(
                              content: "Khác", attitudeType: value!));
                    });
                  },
                ),
              ),
              (attitudeType == AttitudeType.other)
                  ? SizedBox(
                      height: size.height * 0.25,
                      child: TextField(
                        controller: null,
                        onChanged: (value) {
                          reportBloc.eventController.sink.add(
                              ChooseAttitudeContentReportEvent(
                                  content: value.toString(),
                                  attitudeType: AttitudeType.other));
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: size.width * 0.04,
                            right: size.width * 0.04,
                            top: size.height * 0.04,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: GoogleFonts.roboto(
                            color: ColorConstant.grayEE,
                          ),
                          hintText: "Nội dung Phản hồi",
                          //labelText: 'Chi tiết: ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                width: 1, color: ColorConstant.grayEE),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  } else if (title == 'Thông tin của chăm sóc viên') {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          width: size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text('Thiếu thông tin'),
                leading: Radio<SitterInfoType>(
                  value: SitterInfoType.missing,
                  groupValue: sitterInfoType,
                  onChanged: (SitterInfoType? value) {
                    setState(() {
                      reportBloc.eventController.sink.add(
                          ChooseSitterInfoContentReportEvent(
                              content: "Thiếu thông tin",
                              sitterInfoType: value!));
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Sai thông tin'),
                leading: Radio<SitterInfoType>(
                  value: SitterInfoType.wrong,
                  groupValue: sitterInfoType,
                  onChanged: (SitterInfoType? value) {
                    setState(() {
                      reportBloc.eventController.sink.add(
                          ChooseSitterInfoContentReportEvent(
                              content: "Sai thông tin",
                              sitterInfoType: value!));
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Khác'),
                leading: Radio<SitterInfoType>(
                  value: SitterInfoType.other,
                  groupValue: sitterInfoType,
                  onChanged: (SitterInfoType? value) {
                    setState(() {
                      reportBloc.eventController.sink.add(
                          ChooseSitterInfoContentReportEvent(
                              content: "Khác", sitterInfoType: value!));
                    });
                  },
                ),
              ),
              (sitterInfoType == SitterInfoType.other)
                  ? SizedBox(
                      height: size.height * 0.25,
                      child: TextField(
                        onChanged: (value) {
                          reportBloc.eventController.sink.add(
                              ChooseSitterInfoContentReportEvent(
                                  content: value.toString(),
                                  sitterInfoType: SitterInfoType.other));
                        },
                        controller: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: size.width * 0.04,
                            right: size.width * 0.04,
                            top: size.height * 0.04,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: GoogleFonts.roboto(
                            color: ColorConstant.grayEE,
                          ),
                          hintText: "Nội dung Phản hồi",
                          //labelText: 'Chi tiết: ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                width: 1, color: ColorConstant.grayEE),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  } else if (title == 'Khác') {
    return StatefulBuilder(
      builder: (context, setState) => SizedBox(
        height: size.height * 0.25,
        child: TextField(
          controller: null,
          onChanged: (value) {
            reportBloc.eventController.sink.add(FillContentReportEvent(content: value.toString()));
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: size.width * 0.04,
              right: size.width * 0.04,
              top: size.height * 0.04,
            ),
            filled: true,
            fillColor: Colors.white,
            labelStyle: GoogleFonts.roboto(
              color: ColorConstant.grayEE,
            ),
            hintText: "Nội dung Phản hồi",
            //labelText: 'Chi tiết: ',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 1, color: ColorConstant.grayEE),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 1,
                color: ColorConstant.primaryColor,
              ),
            ),
          ),
          keyboardType: TextInputType.multiline,
          maxLines: 6,
        ),
      ),
    );
  } else {
    return StatefulBuilder(
      builder: (context, setState) => const SizedBox(),
    );
  }
}
