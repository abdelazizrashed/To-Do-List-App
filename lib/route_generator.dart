import 'package:flutter/material.dart';
import 'package:todo_list/features/todo_list/presentation/pages/today_page.dart';
import 'package:todo_list/features/todo_list/presentation/pages/upcomming_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //get the argument that have been passed with the route
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => UpCommingPage());
      case '/today':
        return MaterialPageRoute(builder: (_) => TodayPage());
    }
  }
}
