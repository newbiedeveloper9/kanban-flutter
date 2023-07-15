class Board {
  final String name;
  final int totalNumberOfTasks;
  final List<Column> columns;

  Board({
    required this.name,
    required this.totalNumberOfTasks,
    required this.columns,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    var list = List<Map<String, dynamic>>.from(json['columns']);
    var columnsList = list.map((i) => Column.fromJson(i)).toList();

    return Board(
      name: json['name'],
      totalNumberOfTasks: json['totalNumberOfTasks'],
      columns: columnsList,
    );
  }
}

class Column {
  final String name;
  final List<Task> tasks;

  Column({required this.name, required this.tasks});

  factory Column.fromJson(Map<String, dynamic> json) {
    var list = List<Map<String, dynamic>>.from(json['tasks']);
    var tasksList = list.map((i) => Task.fromJson(i)).toList();

    return Column(
      name: json['name'],
      tasks: tasksList,
    );
  }
}

class Task {
  String title;
  String description;

  Task({required this.title, required this.description});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
    );
  }
}
