import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_constant.dart';

class SingleServiceDetail extends StatefulWidget {
  const SingleServiceDetail({Key? key}) : super(key: key);

  @override
  State<SingleServiceDetail> createState() => _SingleServiceDetailState();
}

class _SingleServiceDetailState extends State<SingleServiceDetail> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.greySPBg.withOpacity(0.2),
        bottomOpacity: 0.0,
        elevation: 0.0,
        toolbarHeight: size.height * 0.08,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: size.height * 0.03,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: size.width,
        height: size.height * 0.2,

        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(size.height * 0.04),
              topLeft: Radius.circular(size.height * 0.04),
            ),),
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width * 0.05,
            right: size.width * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    size: size.width * 0.05,
                    color: ColorConstant.primaryColor,
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Text(
                    "Giá dịch vụ: ",
                    style: GoogleFonts.roboto(
                      color: Colors.black54,
                      fontSize: size.height * 0.022,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "90,000",
                    style: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: size.height * 0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                      left: size.width * 0.02,
                    ),
                    child: Text(
                      "1 Giờ",
                      style: GoogleFonts.roboto(
                        color: ColorConstant.grey500,
                        fontSize: size.height * 0.022,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.grey.withOpacity(0.2),
                width: size.width,
                height: 1,
                margin: EdgeInsets.only(
                  top: size.height*0.02,
                  bottom: size.height*0.02,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: size.width * 0.05,
                    color: ColorConstant.yellowStar,
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Text(
                    "Tiết kiệm hơn khi mua gói dịch vụ:",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: size.height * 0.022,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "90,000",
                    style: GoogleFonts.roboto(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.black,
                      fontSize: size.height * 0.02,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(
                    "30,000",
                    style: GoogleFonts.roboto(
                      color: ColorConstant.primaryColor,
                      fontSize: size.height * 0.026,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                      left: size.width * 0.02,
                    ),
                    child: Text(
                      "1 Giờ",
                      style: GoogleFonts.roboto(
                        color: ColorConstant.grey500,
                        fontSize: size.height * 0.022,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.03,
                    ),
                    child: SizedBox(
                      width: size.width * 0.3,
                      height: size.height * 0.055,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          textStyle: TextStyle(
                            fontSize: size.width * 0.045,
                          ),
                        ),
                        child: const Text("Đặt ngay"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Material(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.only(
            left: size.width * 0.05,
            right: size.width * 0.05,
          ),
          decoration: BoxDecoration(
            color: ColorConstant.greySPBg.withOpacity(0.1),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/elderlysitter-bc637.appspot.com/o/Medical%20care-bro%201.png?alt=media&token=f9857edc-40c4-4e7d-9576-1fad9e529d50",
                  width: size.width,
                  height: size.height * 0.4,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  "Trông nom, chăm sóc người già",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: size.height * 0.024,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstant.greySPBg,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: size.width * 0.02,
                        ),
                        child: Text(
                          "Sơn bảo và mình nên viết cái gì đó dài dài ra để ngta đọc vô ngta biết cái này công việc này là như thế nào :) mà giờ Va hông biết ghi gì hết nên để đây cho Khánh đọc á :) ",
                          maxLines: null,
                          style: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
