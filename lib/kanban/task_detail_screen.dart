import 'package:flutter/material.dart';
import '../models.dart' as models;

class TaskDetailScreen extends StatefulWidget {
  final models.Task task;

  const TaskDetailScreen({required this.task, Key? key}) : super(key: key);

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  String _taskDetail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                widget.task.title,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Enter task detail'),
                initialValue: widget.task.description,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    widget.task.description = value ?? '';
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    //TODO: save the task
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
