import 'package:flutter/material.dart';
import 'package:kanban/models.dart' as models;
import 'package:kanban/kanban/task_item.dart';

class TaskColumn extends StatelessWidget {
  final String title;
  final List<models.Task> tasks;
  final void Function(models.Task, List<models.Task>) onAccept;

  const TaskColumn({
    required this.title,
    required this.tasks,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<models.Task>(
      onWillAccept: (data) => true,
      onAccept: (data) => onAccept(data, tasks),
      builder: (context, candidateData, rejectedData) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline5,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => TaskItem(task: tasks[index]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
