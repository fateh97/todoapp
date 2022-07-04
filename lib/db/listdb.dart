import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/model/list.dart';

class ListToDo {
  static final ListToDo instance = ListToDo._init();

  static Database? _database;

  ListToDo._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('list.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
    CREATE TABLE $tableList (
    ${ListFields.id} $idType,
    ${ListFields.list} $textType,
    ${ListFields.description} $textType,
    ${ListFields.time} $textType,
    ${ListFields.completed} $boolType
     )
    ''');
  }

  Future<ToDo> create(ToDo todo) async{
    final db = await instance.database;

    // final json = todo.toJson();
    // final columns =
    //     '${ListFields.list}, ${ListFields.description},${ListFields.time}';
    // final values =
    //     '${json[ListFields.list]}, ${json[ListFields.description]}, ${json[ListFields.time]}';
    // final id = await db.rawInsert('INSERT INTO table_name($columns) VALUES ($values');

    final id = await db.insert(tableList, todo.toJson());
    return todo.copy(id: id);
  }

  // Future<ToDo> readToDo(int id) async {
  //   final db = await instance.database;
  //
  //   final maps = await db.query(
  //       tableList,
  //       columns: ListFields.values,
  //       where: '${ListFields.id} = ?',
  //     whereArgs: [id],
  //   );
  //
  //   if(maps.isNotEmpty){
  //     return ToDo.fromJson(maps.first);
  //   } else {
  //     throw Exception('No Data found');
  //   }
  // }

  Future<List<ToDo>> readAllList() async {
    final db = await instance.database;

    final orderTime = '${ListFields.time} ASC';
    final result = await db.query(tableList, orderBy: orderTime);

    return result.map((json) => ToDo.fromJson(json)).toList();
  }

  Future<int> update(ToDo todo) async {
    final db = await instance.database;

    return db.update(
      tableList,
      todo.toJson(),
      where: '${ListFields.id} = ?',
      whereArgs: [todo.id]
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
        tableList,
        where: '${ListFields.id} = ?',
        whereArgs: [id]
    );
  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }

}