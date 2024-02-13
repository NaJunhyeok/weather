import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/view/startpage.dart';
import 'package:weather/view_model/appviewmodel.dart';
import 'view/searchpage.dart';

void main() async {
  // debugPaintSizeEnabled = true;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(AppViewModel());
      }),
      theme: ThemeData(fontFamily: 'Simple'),
      home: startPage(),
    );
  }
}
