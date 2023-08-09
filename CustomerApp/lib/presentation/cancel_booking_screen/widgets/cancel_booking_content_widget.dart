import 'package:elscus/process/event/cancel_booking_event.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_constant.dart';
import '../../../core/utils/my_enum.dart';
import '../../../process/bloc/cancel_booking_bloc.dart';

StatefulWidget cancelBookingContentWidget(
    BuildContext context,
    String title,
    CancelBookingBloc cancelBookingBloc,
    InfoBookingType infoBookingType,
    CancelBookingType cancelBookingType) {
  var size = MediaQuery.of(context).size;
  if (title == 'Thay đổi thông tin đặt lịch') {
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
                title: const Text('Thay đổi địa chỉ'),
                leading: Radio<InfoBookingType>(
                  value: InfoBookingType.address,
                  groupValue: infoBookingType,
                  onChanged: (InfoBookingType? value) {
                    setState(() {
                      cancelBookingBloc.eventController.sink.add(
                          ChooseInfoBookingContentCancelBookingEvent(
                              content: "Thay đổi địa chỉ", infoBookingType: value!));
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Thay đổi thân nhân'),
                leading: Radio<InfoBookingType>(
                  value: InfoBookingType.elder,
                  groupValue: infoBookingType,
                  onChanged: (InfoBookingType? value) {
                    setState(() {
                      cancelBookingBloc.eventController.sink.add(
                          ChooseInfoBookingContentCancelBookingEvent(
                              content: "Thay đổi thân nhân", infoBookingType: value!));
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Thay đổi gói'),
                leading: Radio<InfoBookingType>(
                  value: InfoBookingType.package,
                  groupValue: infoBookingType,
                  onChanged: (InfoBookingType? value) {
                    setState(() {
                      cancelBookingBloc.eventController.sink.add(
                          ChooseInfoBookingContentCancelBookingEvent(
                              content: "Thay đổi gói", infoBookingType: value!));
                    });
                  },
                ),
              ),

            ],
          ),
        );
      },
    );
  } else if (title == 'Tôi không muốn đặt lịch nữa') {
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
                title: const Text('Thời gian xử lý quá lâu'),
                leading: Radio<CancelBookingType>(
                  value: CancelBookingType.time,
                  groupValue: cancelBookingType,
                  onChanged: (CancelBookingType? value) {
                    setState(() {
                      cancelBookingBloc.eventController.sink.add(
                          ChooseTyeCancelBookingEvent(
                              content: "Thời gian xử lý quá lâu", cancelBookingType: value!));
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Không muốn đặt nữa'),
                leading: Radio<CancelBookingType>(
                  value: CancelBookingType.cancel,
                  groupValue: cancelBookingType,
                  onChanged: (CancelBookingType? value) {
                    setState(() {
                      cancelBookingBloc.eventController.sink.add(
                          ChooseTyeCancelBookingEvent(
                              content: "Không muốn đặt nữa", cancelBookingType: value!));
                    });
                  },
                ),
              ),


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
            cancelBookingBloc.eventController.sink.add(FillContentCancelBookingEvent(content: value.toString()));
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
