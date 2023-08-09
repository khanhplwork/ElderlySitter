import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/core/models/booking_models/booking_history_data_model.dart';
import 'package:elscus/core/utils/my_utils.dart';
import 'package:elscus/presentation/cancel_booking_screen/cancel_booking_screen.dart';
import 'package:elscus/presentation/schedule_screen/widgets/status_in_date_panel.dart';
import 'package:elscus/presentation/schedule_screen/widgets/status_in_schedule_widget.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';

Widget bookingItemWidgetV2(BuildContext context, BookingHistoryDataModel data) {
  var size = MediaQuery.of(context).size;
  return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      padding: EdgeInsets.all(size.height * 0.01),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(size.height * 0.02),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageConstant.icScheduleItem,
            width: size.height * 0.14,
            height: size.height * 0.14,
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.4,
                child: Text(
                  "CSV: ${data.sitter!.fullName}",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                width: size.width * 0.4,
                child: Text(
                  "Người thân: ${data.elderDto.fullName}",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time,
                    size: size.height * 0.02,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  Text(
                    "Ngày tạo: ${data.createDate.day}-${data.createDate.month}-${data.createDate.year}",
                    style: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: size.height * 0.016,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              statusInScheduleWidget(context, data.status),
            ],
          ),
          const Spacer(),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(size.height * 0.008),
            decoration: BoxDecoration(
              color: ColorConstant.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.more_horiz,
              size: size.height * 0.02,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
        ],
      ));
}

Widget cardPurchagedQuest(BuildContext context, BookingHistoryDataModel data) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: ColorConstant.primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.only(top: 10),
    child: Stack(children: [
      Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: (data.sitter != null && data.sitter!.image.isNotEmpty)
                      ? Image.network(data.sitter!.image,
                          width: 75, height: 75, fit: BoxFit.contain)
                      : Icon(
                          Icons.payment,
                          size: 50,
                        ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${data.elderDto.fullName}"),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${MoneyFormatter(amount: data.totalPrice).output.withoutFractionDigits} VNĐ",
                          style: GoogleFonts.roboto(
                            color: ColorConstant.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Ngày bắt đầu: ${DateFormat("dd-MM-yyyy").format(data.startDate)}",
                          style: GoogleFonts.roboto(
                            color: ColorConstant.grey500,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
          ListTile(
            title: Text(
              (data.sitter != null) ? data.sitter!.fullName : "",
            ),
            subtitle: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Chăm sóc viên"),
                ),
              ],
            ),
            // trailing: PopUpMen(
            //   menuList: [
            //     PopupMenuItem(
            //       child: InkWell(
            //         onTap: () async {},
            //         child: ListTile(
            //           leading: Icon(
            //             Icons.remove,
            //           ),
            //           title: Text("Huỷ"),
            //         ),
            //       ),
            //     ),
            //     PopupMenuItem(
            //       child: InkWell(
            //         onTap: () {},
            //         child: ListTile(
            //           leading: Icon(
            //             Icons.add,
            //           ),
            //           title: Text("Thêm ngày"),
            //         ),
            //       ),
            //     ),
            //   ],
            //   icon: CircleAvatar(
            //     backgroundColor: ColorConstant.primaryColor,
            //     // backgroundImage: const NetworkImage(
            //     //   'https://images.unsplash.com/photo-1644982647869-e1337f992828?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80',
            //     // ),
            //     child: Icon(
            //       Icons.menu,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
          ),
        ],
      ),
      //   Positioned(
      //       right: 0,
      //       top: 0,
      //       child: InkWell(
      //         onTap: () async {
      // //  return Menu
      //           // if(Get.find<PlayControllerV2>().checkLocation() == false){

      //           // }
      //           PlayControllerV2 playController = new PlayControllerV2();

      //           bool check = await playController
      //               .checkUserLocation(pQuest.questId.toString());
      //           if (true) {
      //             showAlertDialog(context, pQuest);
      //           } else {
      //             showAlertDialogCheckLocation(context, pQuest);
      //           }
      //         },
      //         child: CircleAvatar(
      //
      //           radius: 30,
      //           child: Icon(
      //             Icons.play_arrow,
      //             color: Colors.white,
      //           ),
      //         ),
      //       ))
    ]),
  );
}

class PopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMen({Key? key, required this.menuList, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}
