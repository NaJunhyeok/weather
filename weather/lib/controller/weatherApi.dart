import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather/view_model/appviewmodel.dart';

class weatherApi {
  AppViewModel appdata = Get.find();
  String apiKey =
      'RxizPAEgVlPXC8OD6dLkYZBZw%2Bz7iSkMaTYXez87La6iQBqX9Ha1Y%2FOQz4wbQPocuzP4kYUvoLlOMnVY%2FuFnoA%3D%3D'; // 공공데이터포털에서 발급받은 API 키를 사용하세요.
  String baseUrl =
      'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst';

  Future<Map<String, dynamic>> fetchWeather() async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl?serviceKey=$apiKey&dataType=json&base_date=20231130&base_time=1800&nx=60&ny=127'),
    );

    if (response.statusCode == 200) {
      // API 응답이 정상일 경우 데이터를 추출합니다.
      Map<String, dynamic> data = await json.decode(response.body);
      String temperature =
          data['response']['body']['items']['item'][0]['obsrValue'];
      appdata.weatherResult.baseDate =
          data['response']['body']['items']['item']['baseDate'];
      return data;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
