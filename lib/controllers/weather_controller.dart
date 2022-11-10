import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/networks/network_calls.dart';
import 'package:weather_app/utils/app_widgets.dart';

import '../db/shared_prefernces.dart';

class WeatherController extends GetxController {
  NetworkCalls networkCalls = NetworkCalls();
  RxBool isEmpty = true.obs;
  RxDouble temp = 1.0.obs;
  RxString cityName = "".obs;
  RxBool isWelcomed = false.obs;
  RxString currentText = "".obs;
  RxString currentIcon = "".obs;
  String rajesh = "my name is rajesh";

  TextEditingController cityNameController = TextEditingController();

  final _sharedPreferences = Get.put(ServicePref());

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    var position = await _determinePosition();
    getWeatherByCord(position);
    await _sharedPreferences.setIsWelcomed(true);
    isWelcomed.value = await _sharedPreferences.getIsWelcomed();
    var city = await _sharedPreferences.getCityName();
    cityNameController.text = city;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future getWeather(BuildContext context) async {
    try {
      var response =
          await networkCalls.getWeatherByCity(cityNameController.text);
      if (response != null) {
        var city =
            await _sharedPreferences.setCityName(cityNameController.text);

        await _sharedPreferences.setTemperature(response['current']['temp_c']);
        await _sharedPreferences.setCondTextAndIcon(
            response['current']['condition']['text'],
            response['current']['condition']['icon']);
        temp.value = await _sharedPreferences.getTemperature();
        cityName.value = await _sharedPreferences.getCityName();
        currentText.value = await _sharedPreferences.getCondText();
        currentIcon.value = await _sharedPreferences.getCondIcon();

        return response;
      }
    } catch (e) {
      print(e.toString());
      AppWidgets.showSnackBar(context, e.toString());
    }
  }

  Future getWeatherByCord(Position position) async {
    try {
      var lat = position.latitude;
      var long = position.longitude;
      var response = await networkCalls.getWeatherByGeoCod(
          lat.toString(), long.toString());

      if (response != null) {
        await _sharedPreferences.setTemperature(response['current']['temp_c']);
        await _sharedPreferences.setCondTextAndIcon(
            response['current']['condition']['text'],
            response['current']['condition']['icon']);
        await _sharedPreferences.setCityName(response['location']['name']);
        temp.value = await _sharedPreferences.getTemperature();
        cityName.value = await _sharedPreferences.getCityName();
        currentText.value = await _sharedPreferences.getCondText();
        currentIcon.value = await _sharedPreferences.getCondIcon();
        return response;
      }
    } catch (e) {
      print(e.toString());
      //AppWidgets.showSnackBar(context, e.toString());
    }
  }
}
