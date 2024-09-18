import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/addToDo.dart';
import 'package:todoapp/widgets/todoList.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String text = 'Simple Text';

  List<String> todoList = [];

  void addTodo({required String todoText}) {
    if (todoList.contains(todoText)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Already Exists'),
            content: Text('This todo data already exists'),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
      return;
    }
    setState(() {
      todoList.add(todoText);
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void updateLocalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todoList', todoList);
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    todoList = (prefs.getStringList('todoList') ?? []).toList();

    setState(() {});
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void showAddTodoBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: EdgeInsets.all(20),
            height: 200,
            child: AddToDo(
              addTodo: addTodo,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.blueGrey[900],
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: showAddTodoBottomSheet,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.blueGrey[900],
              width: double.infinity,
              height: 100,
              child: Center(
                child: Text(
                  'Todo App',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                try {
                  await launchUrl(Uri.parse('https://pub.dev/'));
                } catch (e) {
                  print('Error launching URL: $e');
                }
              },
              leading: Icon(Icons.person),
              title: Text(
                'About Me',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(
                  Uri.parse("mailto:someone@example.com"),
                );
              },
              leading: Icon(Icons.email),
              title: Text(
                'Contact Me',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Todo App"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: showAddTodoBottomSheet,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.add,
              ),
            ),
          ),
        ],
      ),
      body: TodolistBuilder(
        todoList: todoList,
        updateLocalData: updateLocalData,
      ),
    );
  }
}
