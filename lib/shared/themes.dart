import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app_flutter/shared/style/colors.dart';

ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        //من غير type لونه هيبقى ابيض
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.grey),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black, size: 35.0),
      titleTextStyle: TextStyle(
          fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 18.0, color: Colors.black),
    ),
    fontFamily: 'Janna');

ThemeData darkTheme = ThemeData(
    primarySwatch: defaultColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        //من غير type لونه هيبقى ابيض
        backgroundColor: HexColor('333739'),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.grey),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.white, size: 35.0),
      titleTextStyle: const TextStyle(
          fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.bold),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
    ),
    scaffoldBackgroundColor: HexColor('333739'),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 18.0, color: Colors.white),
    ),
    fontFamily: 'Janna');
