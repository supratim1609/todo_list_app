import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/components/dialogue_box.dart';
import 'package:notes_app/components/todolist.dart';
import 'package:notes_app/database/database.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  //open the hive box
  final _myBox= Hive.box('myBox');
  toDoDatabase db=toDoDatabase();

  @override
  void initState() {

    //if this is the 1st time opening the app, create default data
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }else{
      //this is an existing user
      db.loadData();
    }
    super.initState();
  }

  // text controller
  final _controller=TextEditingController();

  //check if the checkbox is checked
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1]= !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  //save a new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  //creating new task
  void createNewTask(){
    showDialog(
        context: context,
        builder: (context) {
          return dialogueBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel:()=> Navigator.of(context).pop(),
          );
        },
    );
  }

  // delete completed task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
          return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value)=> checkBoxChanged(value,index),
              deleteFunction: (context)=> deleteTask(index),
          );
        },
      ),
    );
  }
}
