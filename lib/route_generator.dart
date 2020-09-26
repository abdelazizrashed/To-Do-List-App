import 'package:flutter/material.dart';
import 'package:todo_list/features/todo_list/presentation/pages/history_page.dart';
import 'package:todo_list/features/todo_list/presentation/pages/projects_tasks_page.dart';
import 'package:todo_list/features/todo_list/presentation/pages/today_page.dart';
import 'package:todo_list/features/todo_list/presentation/pages/upcoming_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //get the argument that have been passed with the route
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => UpComingPage());
      case '/today':
        return MaterialPageRoute(builder: (_) => TodayPage());
      case '/projectsTasks':
        return MaterialPageRoute(
            builder: (_) => ProjectsTasksPage(project: args));
      case '/history':
        return MaterialPageRoute(builder: (_) => HistoryPage());
    }
  }
}
