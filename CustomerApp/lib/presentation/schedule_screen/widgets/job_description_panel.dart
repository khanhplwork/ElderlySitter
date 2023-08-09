import 'package:elscus/core/models/booking_models/booking_detail_form_dto.dart';
import 'package:elscus/core/models/booking_models/booking_full_detail_data_model.dart';
import 'package:elscus/presentation/schedule_screen/widgets/service_items_in_jd_dialog.dart';
import 'package:elscus/presentation/schedule_screen/widgets/status_in_schedule_widget.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class JobDescriptionPanel extends StatefulWidget {
  const JobDescriptionPanel({Key? key, required this.bookingDetail})
      : super(key: key);
  final BookingFullDetailDataModel bookingDetail;

  @override
  // ignore: no_logic_in_create_state
  State<JobDescriptionPanel> createState() =>
      // ignore: no_logic_in_create_state
      _JobDescriptionPanelState(bookingDetail: bookingDetail);
}

class _JobDescriptionPanelState extends State<JobDescriptionPanel> {
  _JobDescriptionPanelState({required this.bookingDetail});

  final BookingFullDetailDataModel bookingDetail;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.only(
            left: size.width * 0.05,
            right: size.width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Trạng thái đặt lịch:",
                    style: GoogleFonts.roboto(
                      fontSize: size.height * 0.022,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  statusInScheduleWidget(context, bookingDetail.status),
                ],
              ),

              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                "Nơi làm việc:",
                style: GoogleFonts.roboto(
                  fontSize: size.height * 0.022,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.01,
                  bottom: size.height * 0.02,
                  left: size.width * 0.05,
                ),
                child: Text(
                  //booking.startTime,
                  bookingDetail.address,
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
              Text(
                "Thời gian thực hiện:",
                style: GoogleFonts.roboto(
                  fontSize: size.height * 0.022,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.01,
                  bottom: size.height * 0.02,
                  left: size.width * 0.05,
                ),
                child: Row(
                  children: [
                    Text(
                      //booking.startTime,
                      "Từ: ",
                      style: GoogleFonts.roboto(
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      //booking.startTime,
                      DateFormat("dd - MM - yyyy ").format(bookingDetail.startDate),
                      style: GoogleFonts.roboto(
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(width: size.width*0.03,),
                    Text(
                      //booking.startTime,
                      "Đến: ",
                      style: GoogleFonts.roboto(
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      DateFormat("dd - MM - yyyy ").format(bookingDetail.endDate),
                      style: GoogleFonts.roboto(
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  //top: size.height * 0.01,
                  bottom: size.height * 0.02,
                  //left: size.width * 0.05,
                ),
                child: Text(
                  "Giờ làm việc mỗi ngày:",
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.022,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  //top: size.height * 0.01,
                  bottom: size.height * 0.02,
                  left: size.width * 0.05,
                ),
                child: Text(
                  "${bookingDetail.startTime} - ${bookingDetail.endTime}",
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  //top: size.height * 0.01,
                  bottom: size.height * 0.02,
                  //left: size.width * 0.05,
                ),
                child: Text(
                  "Ghi chú cho CSV",
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.022,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  //top: size.height * 0.01,
                  bottom: size.height * 0.02,
                  left: size.width * 0.05,
                ),
                child: Text(
                  bookingDetail.description,
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      //top: size.height * 0.01,
                      bottom: size.height * 0.02,
                      //left: size.width * 0.05,
                    ),
                    child: Text(
                      "Tổng tiền:",
                      style: GoogleFonts.roboto(
                        fontSize: size.height * 0.022,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      //top: size.height * 0.01,
                      bottom: size.height * 0.02,
                      left: size.width * 0.01,
                    ),
                    child: Text(
                      "${NumberFormat.currency(symbol: "", locale: 'vi-vn').format(bookingDetail.totalPrice.ceil())} VNĐ",
                      style: GoogleFonts.roboto(
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "Gói dịch vụ",
                style: GoogleFonts.roboto(
                  fontSize: size.height * 0.022,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              GestureDetector(
                onTap: (){
                  showServiceItemsInJDDialog(context, bookingDetail);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.01,
                    bottom: size.height * 0.02,
                    left: size.width * 0.05,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 17,
                        color: Color(0xFF5CB85C),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        child: Text(
                          bookingDetail.bookingDetailFormDtos[0].packageName,
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),


              Text(
                "Người được chăm sóc:",
                style: GoogleFonts.roboto(
                  fontSize: size.height * 0.022,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.01,
                    bottom: size.height * 0.02,
                    left: size.width * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //booking.startTime,
                        "Tên: ${bookingDetail.elderDto.fullName}",
                        style: GoogleFonts.roboto(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Text(
                        //booking.startTime,
                        "Tuổi: ${bookingDetail.elderDto.age}",
                        style: GoogleFonts.roboto(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Text(
                        //booking.startTime,
                        "Giới tính: ${bookingDetail.elderDto.gender}",
                        style: GoogleFonts.roboto(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Text(
                        //booking.startTime,
                        "Tình trạng: ${bookingDetail.elderDto.healthStatus}",
                        style: GoogleFonts.roboto(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: size.height * 0.2,
              ),
            ],
          ),
        );
      },
    );
  }
}
