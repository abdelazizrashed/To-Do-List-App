import 'package:flutter/material.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_task.dart';
import 'package:meta/meta.dart';

class FinishedTaskCard extends StatelessWidget {
  final TodoTask task;

  const FinishedTaskCard({
    Key key,
    @required this.task,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(task.taskName),
      ),
    );
  }
}
