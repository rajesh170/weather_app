import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   splashTimer();
  //   super.initState();
  // }

  void splashTimer() {
    Timer(const Duration(seconds: 5), () {
      Get.to(()=> const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    double Height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: const AssetImage('assets/images/bg.jpg'),
            height: Height,
            fit: BoxFit.cover,
          ),
          const Positioned(
            top: 400,
            left: 10,
            child: Text(
              "We show weather for you",
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.redAccent,
                  fontSize: 25,
                  fontWeight: FontWeight.w900),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(

          backgroundColor: Colors.lightBlueAccent,
          child: const Text(
            "Skip",
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900),
          ),
          onPressed: () {
            Get.to(()=> const HomeScreen());
          }),
    );
  }
}
