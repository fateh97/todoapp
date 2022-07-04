final String tableList = 'list';

class ListFields{
  static final List<String> values = [
    //Add all fields
    id, list, description, time
  ];

  static final String id = '_id';
  static final String list = '_list';
  static final String description = '_description';
  static final String time = '_time';
  static final String completed = 'completed';
}

class ToDo {
  final int? id;
  final String list;
  final String description;
  final DateTime createdTime;
  final bool completed;

  const ToDo({
    this.id,
    required this.list,
    required this.description,
    required this.createdTime,
    required this.completed,
  });

  ToDo copy({
    int? id,
    bool? completed,
    String? list,
    String? description,
    DateTime? createdTime,
  }) => ToDo(
    id: id?? this.id,
    completed: completed?? this.completed,
    list: list?? this.list,
    description: description?? this.description,
    createdTime: createdTime?? this.createdTime,
  );

  static ToDo fromJson(Map<String, Object?> json) => ToDo(
    id:json[ListFields.id] as int?,
    list: json[ListFields.list] as String,
    description: json[ListFields.description] as String,
    createdTime: DateTime.parse(json[ListFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    ListFields.id: id,
    ListFields.completed: completed ? 1 : 0,
    ListFields.list: list,
    ListFields.description: description,
    ListFields.time: createdTime.toIso8601String(),
  };
}