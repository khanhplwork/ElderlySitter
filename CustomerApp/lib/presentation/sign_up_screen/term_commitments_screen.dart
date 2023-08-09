import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/process/bloc/cus_bloc.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../process/event/cus_event.dart';

class TermAndCommitmentsScreen extends StatefulWidget {
  TermAndCommitmentsScreen({super.key, required this.cusBloc});
  CusBloc cusBloc;
  @override
  State<TermAndCommitmentsScreen> createState() =>
      _TermAndCommitmentsScreenState(cusBloc: cusBloc);
}

class _TermAndCommitmentsScreenState extends State<TermAndCommitmentsScreen> {
  _TermAndCommitmentsScreenState({required this.cusBloc});
  CusBloc cusBloc;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: size.height * 0.03,
            color: Colors.white,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: size.width * 0.005),
          child: const Text(
            "Điều khoản & Cam kết",
          ),
        ),
        titleTextStyle: GoogleFonts.roboto(
          fontSize: size.height * 0.028,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: EdgeInsets.only(
                  top: size.height*0.03,
                  bottom: size.height*0.05,
                ),
                child: Text(
                  "Chào mừng bạn đến với ứng dụng chăm sóc người cao tuổi dành cho khách hàng. Để tham gia vào ứng dụng của chúng tôi, bạn cần đồng ý và tuân thủ các điều khoản sau: \n 1. Tuổi tác: Bạn phải đủ 18 tuổi để đăng ký và sử dụng ứng dụng chăm sóc người cao tuổi. \n 2. Thông tin cá nhân: Bạn cần cung cấp các thông tin cá nhân chính xác và đầy đủ khi đăng ký tài khoản trên ứng dụng của chúng tôi.\n 3. Sử dụng ứng dụng: Bạn cam kết sử dụng ứng dụng của chúng tôi chỉ để mục đích chăm sóc sức khỏe và hỗ trợ các nhu cầu của người cao tuổi, và không sử dụng ứng dụng để mục đích phi pháp hoặc gây hại cho người khác. \n 4. Bảo mật: Bạn phải bảo mật thông tin tài khoản của mình và không chia sẻ thông tin đăng nhập với bất kỳ ai khác. Nếu bạn phát hiện bất kỳ hoạt động nào bất thường hoặc không chính xác trên tài khoản của mình, vui lòng thông báo cho chúng tôi ngay lập tức. \n 5. Điều chỉnh và hủy bỏ: Chúng tôi có quyền điều chỉnh hoặc hủy bỏ tài khoản của bạn nếu bạn vi phạm bất kỳ điều khoản nào trong thỏa thuận này hoặc chúng tôi phát hiện bất kỳ hoạt động nào đe dọa đến sự an toàn của ứng dụng hoặc người sử dụng. \n 6. Thông báo: Chúng tôi có thể gửi thông báo cho bạn qua email hoặc thông qua ứng dụng của chúng tôi để thông báo về các cập nhật hoặc thay đổi của ứng dụng hoặc về tài khoản của bạn. \n Chúng tôi rất mong đợi được đồng hành cùng bạn trong việc chăm sóc sức khỏe và hỗ trợ người cao tuổi qua ứng dụng của chúng tôi.",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.05,
                  bottom: size.height*0.03,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.055,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      cusBloc.eventController.sink.add(TickIsCommitEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor,
                      textStyle: TextStyle(
                        fontSize: size.width * 0.045,
                      ),
                    ),
                    child: const Text("Xác nhận"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
