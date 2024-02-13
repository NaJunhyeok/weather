import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/controller/change_toXY.dart';
import 'package:weather/controller/location_controller.dart';
import 'package:weather/controller/weatherApi.dart';
import 'package:weather/view/resultpage.dart';
import 'package:weather/view_model/appviewmodel.dart';
import 'package:intl/intl.dart';
import 'dart:math' as Math;

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  @override
  void initState() {
    super.initState();

    getLocationData();
  }

  weatherApi api = weatherApi();
  AppViewModel appdata = Get.find();

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    appdata.locationModel.latitude = location.latitude;
    appdata.locationModel.longitude = location.longitude;
  }

  @override
  Widget build(BuildContext context) {
    api.fetchTemperture();
    final searchController = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var long = appdata.locationModel.longitude;
    var lat = appdata.locationModel.latitude;
    Map_xy mapxy = changelaluMap(
        appdata.locationModel.longitude, appdata.locationModel.latitude);
    var gpsToGridData = ConvGridGps.gpsToGRID(lat, long);
    print(gpsToGridData);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.08,
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          '날씨',
          style: TextStyle(color: Colors.black, fontSize: height * 0.03),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  getLocationData();

                  print(appdata.weatherResult.temperture);
                });
              },
              child: Text('위치 갱신')),
          SizedBox(
            height: height * 0.1,
          ),
          Text('위도 : ${appdata.locationModel.latitude}'),
          Text('경도 : ${appdata.locationModel.longitude}'),
          Text('격자 X: ${mapxy.x}'),
          Text('격자 Y: ${mapxy.y}'),
          SizedBox(
            height: height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Container(
              //   width: width * 0.6,
              //   child: TextFormField(
              //     controller: searchController,
              //     onChanged: (value) {
              //       if (value.isEmpty) {
              //         searchController.clear();
              //       }
              //     },
              //     decoration: InputDecoration(
              //         labelText: '지역 입력',
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //             borderSide: BorderSide(
              //               width: 1,
              //               color: Color(0xff5EA152),
              //             )),
              //         hintText: '예: 서울'),
              //     style: TextStyle(fontSize: height * 0.03),
              //   ),
              // ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {
                    api.fetchTemperture();
                    Get.to(() => resultPage());
                  },
                  child: Text('검색',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: height * 0.03,
                        fontFamily: 'Simple',
                        color: Colors.black,
                      )))
            ],
          )
        ]),
      )),
    );
  }
}

class ConvGridGps {
  static const double RE = 6371.00877; // 지구 반경(km)
  static const double GRID = 5.0; // 격자 간격(km)
  static const double SLAT1 = 30.0; // 투영 위도1(degree)
  static const double SLAT2 = 60.0; // 투영 위도2(degree)
  static const double OLON = 126.0; // 기준점 경도(degree)
  static const double OLAT = 38.0; // 기준점 위도(degree)
  static const double XO = 43; // 기준점 X좌표(GRID)
  static const double YO = 136; // 기1준점 Y좌표(GRID)

  static const double DEGRAD = Math.pi / 180.0;
  static const double RADDEG = 180.0 / Math.pi;

  static double get re => RE / GRID;
  static double get slat1 => SLAT1 * DEGRAD;
  static double get slat2 => SLAT2 * DEGRAD;
  static double get olon => OLON * DEGRAD;
  static double get olat => OLAT * DEGRAD;

  static double get snTmp =>
      Math.tan(Math.pi * 0.25 + slat2 * 0.5) /
      Math.tan(Math.pi * 0.25 + slat1 * 0.5);
  static double get sn =>
      Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(snTmp);

  static double get sfTmp => Math.tan(Math.pi * 0.25 + slat1 * 0.5);
  static double get sf => Math.pow(sfTmp, sn) * Math.cos(slat1) / sn;

  static double get roTmp => Math.tan(Math.pi * 0.25 + olat * 0.5);

  static double get ro => re * sf / Math.pow(roTmp, sn);

  static gridToGPS(int v1, int v2) {
    var rs = {};
    double theta;

    rs['x'] = v1;
    rs['y'] = v2;
    int xn = (v1 - XO).toInt();
    int yn = (ro - v2 + YO).toInt();
    var ra = Math.sqrt(xn * xn + yn * yn);
    if (sn < 0.0) ra = -ra;
    var alat = Math.pow((re * sf / ra), (1.0 / sn));
    alat = 2.0 * Math.atan(alat) - Math.pi * 0.5;

    if (xn.abs() <= 0.0) {
      theta = 0.0;
    } else {
      if (yn.abs() <= 0.0) {
        theta = Math.pi * 0.5;
        if (xn < 0.0) theta = -theta;
      } else
        theta = Math.atan2(xn, yn);
    }
    var alon = theta / sn + olon;
    rs['lat'] = alat * RADDEG;
    rs['lng'] = alon * RADDEG;

    return rs;
  }

  static gpsToGRID(double v1, double v2) {
    var rs = {};
    double theta;

    rs['lat'] = v1;
    rs['lng'] = v2;
    var ra = Math.tan(Math.pi * 0.25 + (v1) * DEGRAD * 0.5);
    ra = re * sf / Math.pow(ra, sn);
    theta = v2 * DEGRAD - olon;
    if (theta > Math.pi) theta -= 2.0 * Math.pi;
    if (theta < -Math.pi) theta += 2.0 * Math.pi;
    theta *= sn;
    rs['x'] = (ra * Math.sin(theta) + XO + 0.5).floor();
    rs['y'] = (ro - ra * Math.cos(theta) + YO + 0.5).floor();

    return rs;
  }
}
