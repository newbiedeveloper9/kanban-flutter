import 'package:flutter/material.dart';

void main() => runApp(KanbanBoard());

class KanbanBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple[900],
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepPurple[700],
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ),
      home: Board(),
    );
  }
}

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  final List<String> _toDoList = ['Task 1', 'Task 2', 'Task 3'];
  final List<String> _inProgressList = ['Task 4'];
  final List<String> _doneList = ['Task 5', 'Task 6'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kanban Board'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            TaskColumn(
              title: 'Todo',
              tasks: _toDoList,
              onAccept: (data) {
                if (!_toDoList.contains(data)) {
                  setState(() {
                    _toDoList.add(data);
                    _inProgressList.remove(data);
                    _doneList.remove(data);
                  });
                }
              },
            ),
            TaskColumn(
              title: 'In Progress',
              tasks: _inProgressList,
              onAccept: (data) {
                if (!_inProgressList.contains(data)) {
                  setState(() {
                    _inProgressList.add(data);
                    _toDoList.remove(data);
                    _doneList.remove(data);
                  });
                }
              },
            ),
            TaskColumn(
              title: 'Done',
              tasks: _doneList,
              onAccept: (data) {
                if (!_doneList.contains(data)) {
                  setState(() {
                    _doneList.add(data);
                    _toDoList.remove(data);
                    _inProgressList.remove(data);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TaskColumn extends StatelessWidget {
  final String title;
  final List<String> tasks;
  final Function(String) onAccept;

  TaskColumn({
    required this.title,
    required this.tasks,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DragTarget<String>(
        onAccept: onAccept,
        builder: (context, candidateData, rejectedData) {
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  offset: Offset(0, 2),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Draggable<String>(
                        data: tasks[index],
                        childWhenDragging: Container(
                          margin: EdgeInsets.all(6.0),
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colors.grey.shade200,
                          ),
                        ),
                        feedback: Material(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.3,
                              maxHeight: MediaQuery.of(context).size.height,
                            ),
                            child: TaskItem(item: tasks[index]),
                          ),
                        ),
                        child: TaskItem(item: tasks[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final String item;

  TaskItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: Text(
          item,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
