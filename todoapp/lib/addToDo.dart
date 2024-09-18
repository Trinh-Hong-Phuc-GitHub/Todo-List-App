import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  void Function({required String todoText}) addTodo;

  AddToDo({super.key, required this.addTodo});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  TextEditingController todoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Add Todo"),
        TextField(
          onSubmitted: (value) {
            if (todoText.text.isNotEmpty) {}
            widget.addTodo(todoText: todoText.text);
            todoText.text = "";
          },
          autofocus: true,
          controller: todoText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            hintText: 'Write your todo here',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (todoText.text.isNotEmpty) {}
            widget.addTodo(todoText: todoText.text);
            todoText.text = "";
          },
          child: Text("Add"),
        ),
      ],
    );
  }
}
