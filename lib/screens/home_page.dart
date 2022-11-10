import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/controllers/weather_controller.dart';

import '../db/shared_prefernces.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    WeatherController weatherController = Get.put(WeatherController());
    final sharedPreferences = Get.find<ServicePref>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.lightBlue, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: weatherController.cityNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter any city";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter your location",
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    weatherController.getWeather(context);
                  }
                },
                child: Text(weatherController.cityNameController.text.isEmpty
                    ? "Save"
                    : "Update"),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Text(
                  "Temperature of ${weatherController.cityName.value}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Text(
                  "${weatherController.temp.value}",
                  style: const TextStyle(fontSize: 36, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Image.network(
                  "https:${weatherController.currentIcon.value}",
                  width: 60,
                  height: 60,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => Text(
                  weatherController.currentText.value,
                  style: const TextStyle(fontSize: 36, color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }
}
