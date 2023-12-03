import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather/view_model/appviewmodel.dart';

class Location {
  double latitude = 0;
  double longitude = 0;

  AppViewModel appdata = Get.find();

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
