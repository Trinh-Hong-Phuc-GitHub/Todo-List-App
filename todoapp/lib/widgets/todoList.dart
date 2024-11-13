import 'package:flutter/material.dart';

class TodoListBuiler extends StatefulWidget {
  List<String> todoList;
  void Function() updateLocalData;

  TodoListBuiler(
      {super.key, required this.todoList, required this.updateLocalData});

  @override
  State<TodoListBuiler> createState() => _TodoListBuilerState();
}

class _TodoListBuilerState extends State<TodoListBuiler> {
  void onItemClicked({required int index}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                widget.todoList.removeAt(index);
              });
              widget.updateLocalData();
              Navigator.pop(context);
            },
            child: Text("Mask As Done!"),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return (widget.todoList.isEmpty)
        ? Text("No item on your todo list")
        : ListView.builder(
      itemCount: widget.todoList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.startToEnd,
          background: Container(
            color: Colors.green,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.check),
                ),
              ],
            ),
          ),
          onDismissed: (direction) {
            setState(() {
              widget.todoList.removeAt(index);
            });
            widget.updateLocalData();
          },
          child: ListTile(
            onTap: () {
              onItemClicked(index: index);
            },
            title: Text(widget.todoList[index]),
          ),
        );
      },
    );
  }
}
