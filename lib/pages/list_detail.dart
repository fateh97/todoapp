import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/db/listdb.dart';
import 'package:todoapp/model/list.dart';
import 'package:todoapp/pages/edit_list_page.dart';

class ListDetailPage extends StatefulWidget {
  final int listId;

  const ListDetailPage({
    Key? key,
    required this.listId,
  }) : super(key: key);

  @override
  _ListDetailPageState createState() => _ListDetailPageState();
}

class _ListDetailPageState extends State<ListDetailPage> {
  late ToDo todo;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    this.todo = await ListDatabase.instance.readList(widget.listId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [editButton(), deleteButton()],
    ),
    body: isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
      padding: EdgeInsets.all(12),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 8),
        children: [
          Text(
            todo.list,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            DateFormat.yMMMd().format(todo.createdTime),
            style: TextStyle(color: Colors.white38),
          ),
          SizedBox(height: 8),
          Text(
            todo.description,
            style: TextStyle(color: Colors.white70, fontSize: 18),
          )
        ],
      ),
    ),
  );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditListPage(todo: todo),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
    icon: Icon(Icons.delete),
    onPressed: () async {
      await ListDatabase.instance.delete(widget.listId);

      Navigator.of(context).pop();
    },
  );
}
