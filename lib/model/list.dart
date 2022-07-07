final String tableList = 'list';

class ListFields{
  static final List<String> values = [
    //Add all fields
    id, list, description, time, number, completed
  ];

  static final String id = '_id';
  static final String list = '_list';
  static final String description = '_description';
  static final String time = '_time';
  static final String completed = 'completed';
  static final String number = 'number';
}

class ToDo {
  final int? id;
  final int number;
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
    required this.number,
  });

  ToDo copy({
    int? id,
    bool? completed,
    int? number,
    String? list,
    String? description,
    DateTime? createdTime,
  }) => ToDo(
    id: id?? this.id,
    completed: completed?? this.completed,
    list: list?? this.list,
    description: description?? this.description,
    createdTime: createdTime?? this.createdTime,
    number: number ?? this.number,
  );

  static ToDo fromJson(Map<String, Object?> json) => ToDo(
    id:json[ListFields.id] as int?,
    list: json[ListFields.list] as String,
    description: json[ListFields.description] as String,
    createdTime: DateTime.parse(json[ListFields.time] as String),
    number: json[ListFields.number] as int,
    completed: json[ListFields.completed] == 1,
  );

  Map<String, Object?> toJson() => {
    ListFields.id: id,
    ListFields.completed: completed ? 1 : 0,
    ListFields.list: list,
    ListFields.description: description,
    ListFields.time: createdTime.toIso8601String(),
    ListFields.number: number,
  };
}