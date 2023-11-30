import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/view_model/appviewmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class resultPage extends StatefulWidget {
  resultPage({Key? key}) : super(key: key);

  @override
  State<resultPage> createState() => _resultPageState();
}

class _resultPageState extends State<resultPage> {
  AppViewModel appdata = Get.find();
  String apiKey =
      'RxizPAEgVlPXC8OD6dLkYZBZw%2Bz7iSkMaTYXez87La6iQBqX9Ha1Y%2FOQz4wbQPocuzP4kYUvoLlOMnVY%2FuFnoA%3D%3D'; // 공공데이터포털에서 발급받은 API 키를 사용하세요.
  String baseUrl =
      'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          '날씨',
          style: TextStyle(color: Colors.black, fontSize: height * 0.03),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(appdata.weatherModel.locationName),
          FutureBuilder(
            future: fetchWeather(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Temperature: ${snapshot.data}\n ');
              }
            },
          ),
        ]),
      )),
    );
  }

  Future<Map<String, dynamic>> fetchWeather() async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl?serviceKey=$apiKey&dataType=json&base_date=20231128&base_time=1400&nx=60&ny=127'),
    );

    if (response.statusCode == 200) {
      // API 응답이 정상일 경우 데이터를 추출합니다.
      Map<String, dynamic> data = await json.decode(response.body);
      String temperature =
          data['response']['body']['items']['item'][0]['obsrValue'];
      return data;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
