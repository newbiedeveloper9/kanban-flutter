import 'package:flutter/material.dart';
import 'package:kanban/kanban/board_page.dart';
import '../models.dart' as models;
import 'api_service.dart';

class KanbanBoard extends StatelessWidget {
  final ApiService apiService = ApiService();

  KanbanBoard({Key? key}) : super(key: key);

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
      home: FutureBuilder<models.Board>(
        future: apiService.fetchBoard('11111111-1111-1111-1111-111111111111'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BoardPage(board: snapshot.data!);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(
            child: TweenAnimationBuilder<Color?>(
              tween: ColorTween(begin: Colors.purple, end: Colors.yellow),
              duration: const Duration(seconds: 2),
              builder: (_, Color? color, __) {
                return SizedBox(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(color)),
                  width: 128,
                  height: 128,
                );
              },
              onEnd: () {},
            ),
          );
        },
      ),
    );
  }
}
