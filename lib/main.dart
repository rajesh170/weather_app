import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/screens/home_page.dart';

import 'controllers/weather_controller.dart';
import 'screens/splash_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WeatherController weatherController = Get.put(WeatherController());
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.orange),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.amberAccent),
          ),
        ),
      ),
      home:weatherController.isWelcomed.value==true?const HomeScreen():  const SplashScreen(),
    );
  }
}
