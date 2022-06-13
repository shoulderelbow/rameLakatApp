import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';

regularText(
    {double fontSize = 15,
      Color color = AppColors.primaryColor,
      FontWeight fontWeight = FontWeight.w400}) =>
    TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);

boldText(
    {double fontSize = 15,
      Color color = AppColors.primaryColor,
      FontWeight fontWeight = FontWeight.w700}) =>
    TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);

userText(
    {double fontSize = 15,
          Color color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
    TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);

