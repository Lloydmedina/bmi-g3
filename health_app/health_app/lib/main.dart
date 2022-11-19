import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:health_app/fitness_app/fitness_app_home_screen.dart';
import 'package:health_app/views/screens/login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage();
  runApp(GetMaterialApp(
    title: 'Fitness App',
    theme: ThemeData(fontFamily: 'Poppins'),
    getPages: [
      GetPage(
          name: '/',
          // page: () => loginScreen(),
          page: () => FitnessAppHomeScreen(),
          transition: Transition.leftToRight),
      GetPage(
          name: '/home',
          page: () => FitnessAppHomeScreen(),
          transition: Transition.leftToRight),
    ],
  ));
}

class GetStorage {}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
