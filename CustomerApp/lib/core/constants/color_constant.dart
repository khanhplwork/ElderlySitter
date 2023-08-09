import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color greenBg = fromHex('9DE5B1');
  static Color primaryColor = fromHex('5CB85C');
  static Color grey500 = fromHex('#a29696');
  static Color grey600 = fromHex('#747070');
  static Color greyAccBg = fromHex('F9F9F9');
  static Color greySPBg = fromHex('D1D1D6');
  static Color redFail = fromHex('FF0101');
  static Color redErrorText = fromHex('#c53530');
  static Color yellowStar = fromHex('F0E93D');
  static Color greyElderBox = fromHex('8F9BB3');
  static Color greyWeekBox = fromHex('F1F5F9');
  static Color yellow1 = fromHex('F4B828');
  static Color blueSky1 = fromHex('00BCD3');
  static Color purple1 = fromHex('7210FF');
  static Color red1 = fromHex('F54336');
  static Color blue1 = fromHex('1A96F0');
  static Color gray4A = fromHex('4A4A4A');
  static Color grayEE = fromHex('EEEEEE');
  static Color grayB0 = fromHex('B0B0BD');
  static Color whiteE3 = fromHex('E3E3E3');
  static const blueGradient = [
    // Color(0xff996699),
    // Color(0xffCCFF33),
    Colors.white,
    Colors.white,
  ];
  static Color yellowFF = fromHex('FFC02D');
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
