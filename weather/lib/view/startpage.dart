import 'package:flutter/material.dart';
import 'package:get/get.dart';

class startPage extends StatefulWidget {
  const startPage({super.key});

  @override
  State<startPage> createState() => _startPageState();
}

class _startPageState extends State<startPage> {
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
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(children: [
          SizedBox(
            height: height * 0.1,
          ),
          Container(
            child: Text('날씨 앱!!'),
          )
        ]),
      )),
    );
  }
}
