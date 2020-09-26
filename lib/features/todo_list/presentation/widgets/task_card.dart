import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_task.dart';
import 'package:meta/meta.dart';
import 'package:todo_list/features/todo_list/presentation/bloc/todo_list_bloc.dart';

class TaskCard extends StatelessWidget {
  final TodoTask task;
  final String route;

  const TaskCard({
    Key key,
    @required this.task,
    @required this.route,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat.MMMEd('en_US');
    return Card(
      child: CheckboxListTile(
        title: Text(task.taskName),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                task.dueDate == null ? '' : dateFormat.format(task.dueDate),
              ),
            ),
            //*Tag
            Expanded(
              child: task.tag == null
                  ? Text('')
                  : Row(
                      children: [
                        Icon(
                          Icons.flag,
                          color: Color(task.tag.tagColor),
                        ),
                        Text(task.tag.tagName),
                      ],
                    ),
            ),
            Expanded(
              child: task.project == null
                  ? Text('')
                  : Text('Project: ${task.project.projectName}'),
            ),
          ],
        ),
        value: task.completed,
        onChanged: (newValue) {
          TodoTask newTask = task.copyWith(completed: newValue);
          BlocProvider.of<TodoListBloc>(context).add(ModifyTaskEvent(newTask));
          if (route == '/') {
            BlocProvider.of<TodoListBloc>(context)
                .add(GetAllUnfinishedTasksEvent());
          }
        },
      ),
    );
  }
}
