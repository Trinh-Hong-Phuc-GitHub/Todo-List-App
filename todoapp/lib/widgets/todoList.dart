import 'package:flutter/material.dart';

class TodolistBuilder extends StatefulWidget {
  List<String> todoList;
  void Function() updateLocalData;

  TodolistBuilder(
      {super.key, required this.todoList, required this.updateLocalData});

  @override
  State<TodolistBuilder> createState() => _TodolistState();
}

class _TodolistState extends State<TodolistBuilder> {
  void onItemCLicked({required int index}) {
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
            child: Text('Mark as Done'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return (widget.todoList.isEmpty)
        ? Center(
            child: Text('No Item In Your Todo List'),
          )
        : ListView.builder(
            itemCount: widget.todoList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.green[300],
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
                  Navigator.pop(context);
                },
                child: ListTile(
                  onTap: () {
                    onItemCLicked(index: index);
                  },
                  title: Text(widget.todoList[index]),
                ),
              );
            },
          );
  }
}
