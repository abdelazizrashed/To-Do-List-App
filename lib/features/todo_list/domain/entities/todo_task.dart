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

  TodoTask copyWith({
    int id,
    String taskName,
    DateTime dueDate,
    TodoTag tag,
    TodoProject project,
    bool completed,
  }) {
    return TodoTask(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      dueDate: dueDate ?? this.dueDate,
      tag: tag ?? this.tag,
      project: project ?? this.project,
      completed: completed ?? this.completed,
    );
  }

  @override
  List<Object> get props => [
        taskName,
        dueDate,
        tag,
        project,
        completed,
      ];
}
