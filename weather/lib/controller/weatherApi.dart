import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather/controller/change_toXY.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:weather/view_model/appviewmodel.dart';

class weatherApi {
  var now = DateTime.now();
  AppViewModel appdata = Get.find();
  String apiKey =
      'RxizPAEgVlPXC8OD6dLkYZBZw%2Bz7iSkMaTYXez87La6iQBqX9Ha1Y%2FOQz4wbQPocuzP4kYUvoLlOMnVY%2FuFnoA%3D%3D'; // 공공데이터포털에서 발급받은 API 키를 사용하세요.
  String baseUrl =
      'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst';

  Future<Map<String, dynamic>> fetchWeather() async {
    print(now.hour);
    var hour = now.hour - 1;
    if (hour == 23) {
      //한시간 전 내용을 받아와야하므로 만약 24시가 되면 date가 다음날로 넘어가기 때문에
      //basedate를 기준의 다음으로 넘겨야함
    }
    double latitude = appdata.locationModel.latitude;
    double longitude = appdata.locationModel.longitude;
    Map_xy mapxy = changelaluMap(longitude, latitude);
    final response = await http.get(
      Uri.parse(
          '$baseUrl?serviceKey=$apiKey&dataType=json&base_date=20231210&base_time=${hour}00&nx=${mapxy.x}&ny=${mapxy.y}'),
    );
    if (response.statusCode == 200) {
      // API 응답이 정상일 경우 데이터를 추출합니다.
      Map<String, dynamic> data = await json.decode(response.body);

      appdata.weatherResult.temperture =
          data['response']['body']['items']['item'][3]['obsrValue'];
      // appdata.weatherResult.baseDate =
      //     data['response']['body']['items']['item']['baseDate'];
      return data;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
