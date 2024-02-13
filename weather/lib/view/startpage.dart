import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/controller/location_controller.dart';
import 'package:weather/view_model/appviewmodel.dart';
import 'searchpage.dart';

class startPage extends StatefulWidget {
  startPage({Key? key}) : super(key: key);

  @override
  State<startPage> createState() => _startPageState();
}

class _startPageState extends State<startPage> {
  @override
  void initState() {
    super.initState();

    getLocationData();
  }

  AppViewModel appdata = Get.find();

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    appdata.locationModel.latitude = location.latitude;
    appdata.locationModel.longitude = location.longitude;
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            '위치 기반 날씨 정보',
            style: TextStyle(color: Colors.black, fontSize: height * 0.03),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  getLocationData();
                  print(
                      '${appdata.locationModel.latitude},${appdata.locationModel.longitude}');
                  Get.to(() => searchPage());
                });
              },
              child: Text(
                '시작',
                style: TextStyle(color: Colors.black, fontSize: height * 0.03),
              )),
        ]),
      ),
    );
  }
}
