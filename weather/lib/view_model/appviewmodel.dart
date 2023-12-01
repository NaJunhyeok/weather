import 'package:get/get.dart';
import 'package:weather/controller/weatherApi.dart';
import 'package:weather/model/weather_model.dart';

import '../model/weather_result.dart';

class AppViewModel extends GetxController {
  WeatherModel _weatherModel = WeatherModel(locationName: '');

  WeatherModel get weatherModel => _weatherModel;

  set weatherModel(WeatherModel weatherModel) {
    _weatherModel = weatherModel;
    update();
  }

  WeatherResult _weatherResult =
      WeatherResult(baseDate: 0, baseTime: '', category: '');

  WeatherResult get weatherResult => _weatherResult;

  set weatherResult(WeatherResult weatherResult) {
    _weatherResult = weatherResult;
    update();
  }
}
