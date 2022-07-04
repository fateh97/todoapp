import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

main(){
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ToDoApp());
}

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



