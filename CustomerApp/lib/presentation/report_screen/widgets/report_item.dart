import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/models/report_models/report_all_data_model.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

Widget reportItem(BuildContext context, ReportAllDataModel report) {
  var size = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.all(size.width * 0.05),
    width: size.width * 0.89,
    height: size.height * 0.3,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(18.5)),
      border: Border.all(
        color: ColorConstant.whiteE3,
        width: 2,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          report.title,
          style: GoogleFonts.roboto(
            color: ColorConstant.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: size.height * 0.024,
          ),
        ),
        Container(
          width: size.width,
          height: 1,
          margin: EdgeInsets.only(
            top: size.height * 0.025,
            bottom: size.height * 0.025,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Người Phản hồi:",
                style: GoogleFonts.roboto(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                  fontSize: size.height * 0.022,
                ),
              ),
              const Spacer(),
              Text(
                report.reporter,
                style: GoogleFonts.roboto(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                  fontSize: size.height * 0.022,
                ),
              ),
            ]),
        Padding(padding: EdgeInsets.only(top: size.height * 0.02)),
        Row(
          children: [
            Text(
              "Người bị Phản hồi: ",
              style: GoogleFonts.roboto(
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.022,
              ),
            ),
            const Spacer(),
            Text(
              report.reportedPerson,
              style: GoogleFonts.roboto(
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.022,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: size.height * 0.02)),
        Row(
          children: [
            Text(
              "Ngày Phản hồi: ",
              style: GoogleFonts.roboto(
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.022,
              ),
            ),
            const Spacer(),
            Text(
              DateFormat("dd - MM - yyyy ").format(report.createDate),
              style: GoogleFonts.roboto(
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.022,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: size.height * 0.02)),
        Row(
          children: [
            Text(
              "Trạng thái: ",
              style: GoogleFonts.roboto(
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.022,
              ),
            ),
            const Spacer(),
            Text(
              report.status,
              style: GoogleFonts.roboto(
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.022,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
