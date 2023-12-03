import 'package:get/get.dart';
import 'package:weather/controller/weatherApi.dart';
import 'package:weather/model/location_model.dart';

import '../model/weather_result.dart';

class AppViewModel extends GetxController {
  LocationModel _locationModel = LocationModel(latitude: 0, longitude: 0);

  LocationModel get locationModel => _locationModel;

  set locationModel(LocationModel locationModel) {
    _locationModel = locationModel;
    update();
  }

  WeatherResult _weatherResult =
      WeatherResult(baseDate: 0, baseTime: '', temperture: '');

  WeatherResult get weatherResult => _weatherResult;

  set weatherResult(WeatherResult weatherResult) {
    _weatherResult = weatherResult;
    update();
  }
}
