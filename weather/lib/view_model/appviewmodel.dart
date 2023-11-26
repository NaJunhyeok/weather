import 'package:get/get.dart';
import 'package:weather/controller/weatherApi.dart';
import 'package:weather/model/weather_model.dart';

class AppViewModel extends GetxController {
  WeatherModel _weatherModel = WeatherModel(locationName: '');

  WeatherModel get weatherModel => _weatherModel;

  set weatherModel(WeatherModel weatherModel) {
    _weatherModel = weatherModel;
    update();
  }
}
