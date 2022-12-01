import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:health_app/fitness_app/fitness_app_home_screen.dart';
import 'package:health_app/fitness_app/recommendation/rec_one.dart';
import 'package:health_app/fitness_app/training/jumping_screen.dart';
import 'package:health_app/fitness_app/training/pushup_screen.dart';
import 'package:health_app/fitness_app/training/running_screen.dart';
import 'package:health_app/fitness_app/training/situp_screen.dart';
import 'package:health_app/fitness_app/ui_view/profile_view.dart';

import 'package:health_app/views/screens/login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  final _datas = GetStorage();
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
      GetPage(
          name: '/running',
          page: () => RunTimer(),
          transition: Transition.leftToRight),
      GetPage(
          name: '/situp',
          page: () => SitupTimer(),
          transition: Transition.leftToRight),
      GetPage(
          name: '/jumpping',
          page: () => JumpingTimer(),
          transition: Transition.leftToRight),
      GetPage(
          name: '/pushup',
          page: () => PushupTimer(),
          transition: Transition.leftToRight),
      GetPage(
          name: '/recone',
          page: () => RecOne(),
          transition: Transition.leftToRight),
      GetPage(
          name: '/profile',
          page: () => ProfileView(),
          transition: Transition.leftToRight),
    ],
  ));
}

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
