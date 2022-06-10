

import 'package:flutter/material.dart';

import 'colors.dart';

abstract class UIStyles {
  static const sourceSansProFamily = 'Source Sans Pro';


  static TextStyle appBarTextStyle({Color color = UIColors.black}) => TextStyle(
    fontFamily: sourceSansProFamily,
    color: color,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 26,
  );
  static TextStyle w600s18({Color color = UIColors.black}) => TextStyle(
    fontFamily: sourceSansProFamily,
    color: color,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 18,
  );
  static TextStyle w600s16({Color color = UIColors.black}) => TextStyle(
    fontFamily: sourceSansProFamily,
    color: color,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 16,
  );
  static TextStyle w700s18({Color color = UIColors.black}) => TextStyle(
    fontFamily: sourceSansProFamily,
    color: color,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 18,
  );
  static TextStyle w600s29Primary({Color color = UIColors.primaryColor}) => TextStyle(
    fontFamily: sourceSansProFamily,
    color: color,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 29,
  );
  static TextStyle w600s18Primary({Color color = UIColors.primaryColor}) => TextStyle(
    fontFamily: sourceSansProFamily,
    color: color,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 18,
  );
  static TextStyle w400s16White({Color color = UIColors.white}) => TextStyle(
    fontFamily: sourceSansProFamily,
    color: color,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 16,
  );
  static TextStyle w600s20White({Color color = UIColors.white}) => TextStyle(
    fontFamily: sourceSansProFamily,
    color: color,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 20,
  );


}