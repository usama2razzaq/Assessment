import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products/reuseable_widgets/shared_utils.dart';

const String FontFamily = "OpenSans";
var theme_color = Colors.amber;
var theme_color_black = getColorFromHex("#263C3C");
// const double vehicle_show_width_web = 400;
// const double vehicle_show_height_web = 370;
//
// const double vehicle_show_width_mobile = 200;
// const double vehicle_show_height_mobile = 150;
//
// const double vehicle_show_radius_web = 8;
// const double vehicle_show_radius_mobile = 6;

TextStyle getTextTyle(String fontStyle, double fontsize,
    {color = Colors.black}) {
  FontWeight fontWeight = FontWeight.w300;

  switch (fontStyle) {
    case "":
      fontWeight = FontWeight.w300;
      break;

    case "r":
      fontWeight = FontWeight.w500;
      break;

    case "m":
      fontWeight = FontWeight.w600;
      break;

    case "sb":
      fontWeight = FontWeight.w700;
      break;

    case "b":
      fontWeight = FontWeight.w800;
      break;

    case "eb":
      fontWeight = FontWeight.w900;
      break;
  }

  return TextStyle(
      fontFamily: FontFamily,
      fontWeight: fontWeight,
      color: color,
      fontSize: fontsize,
      decoration: TextDecoration.none);
}
