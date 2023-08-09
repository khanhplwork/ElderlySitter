import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/presentation/onboarding_screen/widgets/onboarding_sheet_one.dart';
import 'package:elscus/presentation/onboarding_screen/widgets/onboarding_sheet_three.dart';
import 'package:elscus/presentation/onboarding_screen/widgets/onboarding_sheet_two.dart';
import 'package:elscus/presentation/onboarding_screen/widgets/render_boarding_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intro_slider/intro_slider.dart';

import '../../fire_base/login_with_google_nav.dart';

class OnboardingScreen extends StatefulWidget {

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _elsBox = Hive.box('elsBox');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _elsBox.put('isOpened', true);
    // FirebaseMessaging.instance.getInitialMessage().then((value) {
    //   (value != null)
    //       ? Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const LoginWithGoogleNav()))
    //       : print('');
    // });
  }

  Widget inputContent(index) {
    if (index == 0) {
      return const OnboardingSheetOne();
    } else if (index == 1) {
      return const OnboardingSheetTwo();
    } else {
      return const OnboardingSheetThree();
    }
  }

  List<Widget> renderListCustomTabs() {
    return List.generate(3, (index) => inputContent(index));
  }

  @override
  Widget build(BuildContext context) {
    void onDonePress() {
      Navigator.pushNamed(context, '/loginWithGoogleNav');
    }
    return Container(
      margin: const EdgeInsets.all(0),
      child: IntroSlider(
        renderNextBtn: renderNextBtn(),
        renderSkipBtn: renderSkipBtn(context),
        renderDoneBtn: renderDoneBtn(context),
        listCustomTabs: renderListCustomTabs(),
        onDonePress: onDonePress,
        typeDotAnimation: DotSliderAnimation.SIZE_TRANSITION,
        sizeDot: 10,

        colorDot: ColorConstant.primaryColor,
      ),
    );
  }
}
