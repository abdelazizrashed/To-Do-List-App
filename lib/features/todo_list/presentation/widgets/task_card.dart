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
    bool hasDueDate = (task.dueDate != null) ? true : false;
    bool hasTag = (task.tag != null) ? true : false;
    bool hasProject = (task.project != null) ? true : false;
    return Card(
      child: CheckboxListTile(
        title: Text(task.taskName),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: buildDateTagProjectList(
              hasDueDate, hasTag, hasProject, dateFormat),
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

  List<Widget> buildDateTagProjectList(
      bool hasDueDate, bool hasTag, bool hasProject, DateFormat dateFormat) {
    List<Widget> widgetList = [];
    if (hasDueDate) {
      widgetList.add(buildDueDate(dateFormat));
    }
    if (hasTag) {
      widgetList.add(buildTag());
    }
    if (hasProject) {
      widgetList.add(buildProject());
    }
    return widgetList;
  }

  Expanded buildProject() {
    return Expanded(
      child: task.project == null
          ? Text('')
          : Text('Project: ${task.project.projectName}'),
    );
  }

  Expanded buildTag() {
    return Expanded(
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
    );
  }

  Expanded buildDueDate(DateFormat dateFormat) {
    DateTime now = DateTime.now();
    String dueDate = '';
    if (now.day == task.dueDate?.day &&
        now.month == task.dueDate?.month &&
        now.year == task.dueDate?.year) {
      dueDate = 'Today';
    } else if (now.day + 1 == task.dueDate?.day &&
        now.month == task.dueDate?.month &&
        now.year == task.dueDate?.year) {
      dueDate = 'Tomorrow';
    } else {
      dueDate = dateFormat.format(task.dueDate);
    }

    return Expanded(
      child: Text(
        task.dueDate == null ? '' : dueDate,
      ),
    );
  }
}
