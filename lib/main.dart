import 'package:flutter/material.dart';

main() => runApp(ToDoApp());

class ToDoApp extends StatefulWidget {
  const ToDoApp({Key? key}) : super(key: key);
  @override
  _ToDoAppState createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp>{
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: textController,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: (){
            print(textController.text);
          },
        ),
        ),
    );
  }
}

class ToDo {
  final int? id;
  final String list;

  ToDo({this.id, required this.list});

  factory ToDo.fromMap(Map<String, dynamic> json)=> new ToDo(
    id: json['id'],
    list: json['list'],
  );

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'list': list,
    };
  }
}