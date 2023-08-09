
import 'package:elscus/presentation/history_screen/widgets/cancel_history_panel.dart';
import 'package:elscus/presentation/history_screen/widgets/done_history_panel.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_constant.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TabBar createTabBar() {
      return TabBar(
        indicatorColor: ColorConstant.primaryColor,
        labelPadding: const EdgeInsets.all(10),
        tabs: [

          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              textAlign: TextAlign.center,
              "Hoàn Thành",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              textAlign: TextAlign.center,
              "Đã Hủy",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
        ],
        isScrollable: true,
      );
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Lịch Sử Đặt Lịch",
            ),
          ),
          titleTextStyle: GoogleFonts.roboto(
            fontSize: size.height * 0.028,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          bottom: createTabBar(),
        ),
        body: Material(
          child: Container(
            color: Colors.white,
            child: TabBarView(
              children: [
                Material(
                  child: Container(
                    color: Colors.white,
                    width: size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          const DoneHistoryPanel(),
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
                  child: Container(
                    color: Colors.white,
                    width: size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          const CancelHistoryPanel(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
