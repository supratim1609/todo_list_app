import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  //initalize hive
  await Hive.initFlutter();

  //open a box
  var box= await Hive.openBox('mybox');


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow
      ),
      home: homePage(),
    );
  }
}
