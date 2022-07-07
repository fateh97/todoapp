import 'package:flutter/material.dart';
import 'package:todoapp/db/listdb.dart';
import 'package:todoapp/model/list.dart';
import 'package:todoapp/widget/list_form.dart';

class EditListPage extends StatefulWidget {
  final ToDo? todo;

  const EditListPage({
    Key? key,
    this.todo,
  }) : super(key: key);
  @override
  _EditListPageState createState() => _EditListPageState();
}

class _EditListPageState extends State<EditListPage> {
  final _formKey = GlobalKey<FormState>();
  late bool completed;
  late int number;
  late String list;
  late String description;

  @override
  void initState() {
    super.initState();

    completed = widget.todo?. completed?? false;
    number = widget.todo?.number ?? 0;
    list = widget.todo?.list ?? '';
    description = widget.todo?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: ListFormWidget(
        completed: completed,
        list: list,
        description: description,
        onChangedImportant: (completed) =>
            setState(() => this.completed = completed),
        onChangedNumber: (number) => setState(() => this.number = number),
        onChangedTitle: (list) => setState(() => this.list = list),
        onChangedDescription: (description) =>
            setState(() => this.description = description),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = list.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateList,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateList() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.todo != null;

      if (isUpdating) {
        await updateList();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateList() async {
    final listnote = widget.todo!.copy(
      completed: completed,
      list: list,
      description: description,
    );
    await ListDatabase.instance.update(listnote);
  }

  Future addNote() async {
    final listnote = ToDo(
      list: list,
      completed: true,
      number: number,
      description: description,
      createdTime: DateTime.now(),
    );

    await ListDatabase.instance.create(listnote);
  }
}
