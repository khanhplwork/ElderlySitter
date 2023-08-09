import 'package:elscus/presentation/home_screen/widget/single_service_detail.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_constant.dart';

Widget singleServiceItem(BuildContext context, String serviceName){
  var size = MediaQuery.of(context).size;
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorConstant.greySPBg,
        ),
      ),
      SizedBox(
        width: size.width * 0.75,
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width * 0.02,
          ),
          child: Text(
            serviceName,
            maxLines: null,
            style: GoogleFonts.roboto(
              color: Colors.grey,
              fontSize: size.height * 0.02,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      const Spacer(),
      GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  SingleServiceDetail(),));
        },
        child: Container(
          width: size.width * 0.05,
          height: size.width * 0.05,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
            ColorConstant.primaryColor.withOpacity(0.2),
          ),
          child: Icon(
            Icons.arrow_forward,
            size: size.width * 0.03,
            color: ColorConstant.primaryColor,
          ),
        ),
      ),
    ],
  );
}