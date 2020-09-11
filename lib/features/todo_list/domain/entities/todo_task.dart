import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_tag.dart';

class TodoTask extends Equatable {
  int id;
  final String taskName;
  final DateTime dueDate;
  final TodoTag tag;
  final TodoProject project;
  final bool completed;

  TodoTask({
    this.id,
    @required this.taskName,
    this.dueDate,
    this.tag,
    this.project,
    this.completed,
  });

  @override
  List<Object> get props => [
        taskName,
        dueDate,
        tag,
        project,
        completed,
      ];
}
