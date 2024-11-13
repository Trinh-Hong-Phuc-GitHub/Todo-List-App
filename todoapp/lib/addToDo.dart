import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  void Function({required String todoText}) addToDo;

  AddToDo({super.key, required this.addToDo});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  TextEditingController todoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Add Todo",
        ),
        TextField(
          onSubmitted: (value) {
            if (todoText.text.isNotEmpty) {
              widget.addToDo(todoText: todoText.text);
            }
            todoText.text = "";
          },
          autofocus: true,
          controller: todoText,
          decoration: InputDecoration(
            hintText: "Write your todo here...",
            contentPadding: EdgeInsets.all(5),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (todoText.text.isNotEmpty) {
              widget.addToDo(todoText: todoText.text);
            }
            todoText.text = "";
          },
          child: Text("Add"),
        ),
      ],
    );
  }
}
