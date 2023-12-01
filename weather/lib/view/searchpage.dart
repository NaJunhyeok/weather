import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/controller/weatherApi.dart';
import 'package:weather/view/resultpage.dart';
import 'package:weather/view_model/appviewmodel.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  weatherApi api = weatherApi();
  AppViewModel appdata = Get.find();
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
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
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(children: [
          SizedBox(
            height: height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: width * 0.6,
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      searchController.clear();
                    }
                  },
                  decoration: InputDecoration(
                      labelText: '지역 입력',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xff5EA152),
                          )),
                      hintText: '예: 서울'),
                  style: TextStyle(fontSize: height * 0.03),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {
                    appdata.weatherModel.locationName = searchController.text;
                    api.fetchWeather();
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
