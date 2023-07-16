import 'package:flutter/material.dart';
import 'package:notes_app/components/MyButton.dart';

class dialogueBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  dialogueBox({Key? key, required this.controller, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: Container(
        height:120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
              hintText: "Add new task",
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            //save button
            MyButton(name: "Save", onPressed: onSave),

            const SizedBox(width: 10),

            //cancel button
            MyButton(name: "Cancel", onPressed: onCancel),
          ],
          )
        ],
        ),
      ),
    );
  }
}
