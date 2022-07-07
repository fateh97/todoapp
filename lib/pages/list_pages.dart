import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todoapp/db/listdb.dart';
import 'package:todoapp/model/list.dart';
import 'package:todoapp/pages/edit_list_page.dart';
import 'package:todoapp/pages/list_detail.dart';
import 'package:todoapp/widget/list_card.dart';

class ToDoPage extends StatefulWidget{
  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage>{
  late List<ToDo> todos;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    ListDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.todos = (await ListDatabase.instance.readAllList()).cast<ToDo>();

    setState(() => isLoading = false);
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        'To-Do',
        style: TextStyle(fontSize: 24),
      ),
    ),
    body: Center(
      child: isLoading
          ? CircularProgressIndicator()
          : todos.isEmpty
          ? Text(
        'No To-Do List',
        style: TextStyle(color: Colors.white, fontSize: 24),
      )
          : buildNotes(),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.black,
      child: Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EditListPage()),
        );

        refreshNotes();
      },
    ),
  );

  Widget buildNotes() => StaggeredGridView.countBuilder(
    padding: EdgeInsets.all(8),
    itemCount: todos.length,
    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      final list = todos[index];

      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ListDetailPage(listId: list.id!),
          ));

          refreshNotes();
        },
        child: ListCardWidget(todo: list, index: index),
      );
    },
  );
}