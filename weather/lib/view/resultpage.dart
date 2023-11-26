import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/view_model/appviewmodel.dart';

class resultPage extends StatefulWidget {
  resultPage({Key? key}) : super(key: key);

  @override
  State<resultPage> createState() => _resultPageState();
}

class _resultPageState extends State<resultPage> {
  AppViewModel appdata = Get.find();

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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(appdata.weatherModel.locationName)]),
      )),
    );
  }
}
