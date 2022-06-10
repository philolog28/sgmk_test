import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgmk_test/ui/colors.dart';

abstract class UIIcons {
  static const _iconsPath = 'assets/icons';

  static SvgPicture arrowBack({ Size? size,Color? color}) =>
      SvgPicture.asset(
        '$_iconsPath/arrow_back.svg',
        height: size?.height,
        width: size?.width,
        color: color,
      );
  static SvgPicture cart({ Size? size,Color? color,}) =>
      SvgPicture.asset(
        '$_iconsPath/cart.svg',
        height: size?.height,
        width: size?.width,
        color: UIColors.white,
      );

  static SvgPicture plus({ Size? size,Color? color}) =>
      SvgPicture.asset(
        '$_iconsPath/plus.svg',
        height: size?.height,
        width: size?.width,
        color: color,
      );

  static SvgPicture minus({ Size? size,Color? color}) =>
      SvgPicture.asset(
        '$_iconsPath/minus.svg',
        height: size?.height,
        width: size?.width,
        color: color,
      );
  static SvgPicture clear({ Size? size,Color? color}) =>
      SvgPicture.asset(
        '$_iconsPath/clear.svg',
        height: size?.height,
        width: size?.width,
        color: color,
      );
  static SvgPicture person({ Size? size,Color? color}) =>
      SvgPicture.asset(
        '$_iconsPath/person.svg',
        height: size?.height,
        width: size?.width,
        color: color,
      );
}