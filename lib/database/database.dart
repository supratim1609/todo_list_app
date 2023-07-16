import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class toDoDatabase{
  List toDoList=[];

  //reference the created box
  final _myBox=Hive.box('myBox');

  //run this method if the app is opened 1st time ever
  void createInitialData(){
    toDoList=[
      ["Drink water", false],
      ["Excercise", false],
    ];
  }

  //load the data from the database
  void loadData(){
    toDoList=_myBox.get("TODOLIST");
  }

  //update the database
  void updateDatabase(){
    _myBox.put("TODOLIST", toDoList);
  }
}