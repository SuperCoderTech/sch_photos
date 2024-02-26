import 'package:flutter/material.dart';

class AppTheme {
  static const Color BG = Color(0xfff8f9fa);

  //static const Color PROF_COLOR = Color(0xFF356C95);
  static const Color PROF_COLOR = Color(0xFF487F63);
  static const Color primaryColor = Color(0XFF6C2C80);

  //static const Color primaryColor = Color(0xFF54D3C2);
  static const Color secondaryColor = Color(0xFF54D3C2);

  static const Color darkPrimary = Color(0xFF2B333D);

  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF767676);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);

  static const Color nearlyBlack = Color(0xFF213333);

  static const String fontName = 'WorkSans';

  static final lightTheme = ThemeData(
      fontFamily: fontName,
      colorScheme: ColorScheme.light(primary: BG),
      backgroundColor: BG,
      scaffoldBackgroundColor: BG,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: darkText,
      ),
      primaryColor: BG,
      textTheme: textTheme,
      platform: TargetPlatform.iOS);

  static final darkTheme = ThemeData(
      fontFamily: fontName,
      bottomAppBarColor: Colors.black,
      primaryColor: darkPrimary,
      scaffoldBackgroundColor: darkPrimary,
      colorScheme: ColorScheme.dark(primary: darkPrimary),
      textTheme: darkTextTheme,
      platform: TargetPlatform.iOS);

  static const TextTheme textTheme = TextTheme(
    /* 36*/
    headline1: display1,

    /* 36*/
    headline2: display1,

    /* 36 */
    headline3: display1,

    /* 24*/
    headline4: headline4,

    /* 22 */
    headline5: headline5,

    /* 20  bold*/
    headline6: title,

    /* 18 less bold */
    subtitle1: sub_title1,

    /* 16 less bold */
    subtitle2: subtitle,

    /*16 normal*/
    bodyText1: body1,

    /*14 normal*/
    bodyText2: body2,

    /*12 normal*/
    caption: caption,
  );

  static const TextTheme darkTextTheme = TextTheme(
    /* 36*/
    headline1: display1_light,

    /* 36*/
    headline2: display1_light,

    /* 36 */
    headline3: display1_light,

    /* 24*/
    headline4: headline4_light,

    /* 22 */
    headline5: headline5_light,

    /* 20  bold*/
    headline6: title_light,

    /* 18 less bold */
    subtitle1: sub_title1_light,

    /* 16 less bold */
    subtitle2: subtitle_light,

    /*16 normal*/
    bodyText1: body1_light,

    /*14 normal*/
    bodyText2: body2_light,

    /*12 normal*/
    caption: caption_light,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline4 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline5 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 22,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle sub_title1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static const TextStyle display1_light = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: nearlyWhite,
  );

  static const TextStyle headline4_light = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.4,
    height: 0.9,
    color: nearlyWhite,
  );

  static const TextStyle headline5_light = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 22,
    letterSpacing: 0.27,
    color: nearlyWhite,
  );

  static const TextStyle sub_title1_light = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    letterSpacing: 0.18,
    color: nearlyWhite,
  );

  static const TextStyle title_light = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    letterSpacing: 0.18,
    color: nearlyWhite,
  );

  static const TextStyle subtitle_light = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: -0.04,
    color: nearlyWhite,
  );

  static const TextStyle body2_light = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: nearlyWhite,
  );

  static const TextStyle body1_light = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: nearlyWhite,
  );

  static const TextStyle caption_light = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: nearlyWhite, // was lightText
  );

  static getTextStyle({fontSize = 18.0, fontWeight = FontWeight.bold}) {
    return TextStyle(
      fontFamily: fontName,
      fontWeight: fontWeight,
      fontSize: fontSize,
      letterSpacing: 0.5,
    );
  }

  static getTextStyle2(
      {fontSize = 18.0, fontWeight = FontWeight.bold, Color? color}) {
    return TextStyle(
        fontFamily: fontName,
        fontWeight: fontWeight,
        fontSize: fontSize,
        letterSpacing: 0.5,
        color: color);
  }
}