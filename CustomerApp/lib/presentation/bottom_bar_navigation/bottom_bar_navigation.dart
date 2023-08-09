import 'package:elscus/presentation/account_screen/account_screen.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/screen/booking_elder.dart';
import 'package:elscus/presentation/home_screen/home_screen.dart';
import 'package:elscus/presentation/service_package_screen/service_package_screen.dart';
import 'package:elscus/presentation/splash_screen/splash_screen.dart';
import 'package:elscus/presentation/timeline_tracking/screen/list_item_waitting.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/color_constant.dart';
import '../../core/constants/image_constant.dart';
import '../schedule_screen/schedule_screen.dart';
import 'dart:math' as math;

class BottomBarNavigation extends StatefulWidget {
  int selectedIndex = 0;

  bool isBottomNav = true;

  BottomBarNavigation(
      {super.key, required this.selectedIndex, required this.isBottomNav});

  @override
  State<BottomBarNavigation> createState() => _BottomBarNavigationState(
      selectedIndex: selectedIndex, isBottomNav: isBottomNav);
}

class _BottomBarNavigationState extends State<BottomBarNavigation> {
  int selectedIndex = 0;
  bool isBottomNav = true;

  _BottomBarNavigationState(
      {required this.selectedIndex, required this.isBottomNav});

  Widget? pageCaller(index) {
    switch (selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const TimelineListInprogress();
      case 3:
        return const ScheduleScreen();
      case 4:
        return const AccountScreen();
      case 2:
        return ElderBookingScreen();

      default:
        return const SplashScreen();
    }
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ElderBookingScreen(),
          ));
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: InkWell(
          splashColor: ColorConstant.primaryColor,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ElderBookingScreen(),
                ));
          },
          child: Center(
            child: Icon(Icons.add),
          ),
        ),
      ),
      body: pageCaller(selectedIndex),
      bottomNavigationBar: isBottomNav == true
          ? BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(ImageConstant.icHome),
                  ),
                  label: 'Trang chủ',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(ImageConstant.icService),
                  ),
                  label: 'Lịch trình',
                ),
                BottomNavigationBarItem(
                    label: "Đặt lịch", icon: Icon(Icons.add)),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(ImageConstant.icSchedule),
                  ),
                  label: 'Lịch sử',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(ImageConstant.icAccount),
                  ),
                  label: 'Tài khoản',
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: ColorConstant.primaryColor,
              selectedLabelStyle: GoogleFonts.roboto(
                color: ColorConstant.primaryColor,
              ),
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: GoogleFonts.roboto(
                color: Colors.black,
              ),
              showUnselectedLabels: true,
              elevation: 0,
              onTap: _onItemTapped,
            )
          : Container(
              height: 0,
            ),
    );
  }
}
