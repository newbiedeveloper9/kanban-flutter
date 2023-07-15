import 'package:flutter/material.dart';
import 'package:kanban/kanban/task_detail_screen.dart';
import 'package:kanban/models.dart' as models;

class TaskItem extends StatelessWidget {
  final models.Task task;

  const TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return Draggable<models.Task>(
      data: task,
      child: buildCard(context),
      feedback: SizedBox(
        width: MediaQuery.of(context).size.width * 0.31,
        child: Material(
          child: buildCard(context),
        ),
      ),
      childWhenDragging: Container(
        margin: const EdgeInsets.all(6.0),
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.grey.shade200,
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailScreen(task: task),
          ),
        );
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          title: Text(task.title),
        ),
      ),
    );
  }
}
