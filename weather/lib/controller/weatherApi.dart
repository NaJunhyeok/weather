import 'dart:convert' as convert;
import 'package:weather/model/weather_result.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class weatherApi {
  var apiKey =
      'RxizPAEgVlPXC8OD6dLkYZBZw%2Bz7iSkMaTYXez87La6iQBqX9Ha1Y%2FOQz4wbQPocuzP4kYUvoLlOMnVY%2FuFnoA%3D%3D';

  Future<List<WeatherResult>?> loadWeather() async {
    var addr = '서울';
    String baseUrl =
        'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst';
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final body = convert.utf8.decode(response.bodyBytes);

      final xml = Xml2Json()..parse(body);
      final json = xml.toParker();

      Map<String, dynamic> jsonResult = convert.json.decode(json);
      final jsonWeather = jsonResult['response']['body']['items'];

      if (jsonWeather['item'] != null) {
        List<dynamic> list = jsonWeather['item'];

        return list
            .map<WeatherResult>((item) => WeatherResult.fromJson(item))
            .toList();
      }
    }
  }
}
