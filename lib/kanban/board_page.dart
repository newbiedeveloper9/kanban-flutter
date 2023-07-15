import 'package:flutter/material.dart';
import 'package:kanban/models.dart' as models;
import 'package:kanban/kanban/task_column.dart';

class BoardPage extends StatefulWidget {
  final models.Board board;

  const BoardPage({required this.board});

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  List<models.Column> columns = [];

  @override
  void initState() {
    super.initState();
    columns = widget.board.columns;
  }

  void _moveTask(models.Task task, List<models.Task> toList) {
    setState(() {
      columns.forEach((column) {
        column.tasks.remove(task);
      });
      toList.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.board.name +
            ' | ' +
            widget.board.totalNumberOfTasks.toString() +
            ' zadań'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: columns.map((column) {
            return Expanded(
              child: TaskColumn(
                title: column.name,
                tasks: column.tasks,
                onAccept: _moveTask,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
