import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/image_constant.dart';
import '../../../core/models/elder_models/customer_dto.dart';

StatefulWidget customerItem(BuildContext context, List<CustomerDto> listCus) {
  var size = MediaQuery.of(context).size;
  PageController pageController = PageController();
  int indexCus = 0;

  return StatefulBuilder(
    builder: (context, setState) {
      nextCus() {
        setState(() {
          indexCus++;
          pageController.jumpToPage(indexCus);
        });
      }

      backCus() {
        setState(() {
          indexCus--;
          pageController.jumpToPage(indexCus);
        });
      }

      return Container(
        margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.02),
        width: double.infinity,
        height: size.height * 0.32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            PageView.custom(
              controller: pageController,
              childrenDelegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  // return bookingItemWidget(context," value[index].title");

                  return Padding(

                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05, vertical: size.height * 0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            ImageConstant.icPersonal,
                            width: size.width * 0.15,
                            height: size.width * 0.15,
                          ),
                        ),
                        SizedBox(height: size.height*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Người dùng:",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  listCus[index].fullName,
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
                                  listCus[index].gender,
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
                              "Số điện thoại:",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  listCus[index].phone,
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
                              "Địa chỉ:  ",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  listCus[index].address,
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
                  );
                },
                childCount: listCus.length,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                indexCus != 0
                    ? InkWell(
                        onTap: backCus,
                        child: SizedBox(
                          height: double.infinity,
                          width: 20,
                          child: Icon(Icons.arrow_back_ios_outlined),
                        ),
                      )
                    : SizedBox.shrink(),
                indexCus != listCus.length - 1
                    ? InkWell(
                        onTap: nextCus,
                        child: SizedBox(
                          height: double.infinity,
                          width: 20,
                          child: Icon(Icons.arrow_forward_ios_outlined),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            )
          ],
        ),
      );
    },
  );
}
