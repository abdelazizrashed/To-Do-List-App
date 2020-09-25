import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/widgets/side_menu_drawer.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_task.dart';
import 'package:todo_list/features/todo_list/presentation/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/display_message.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/loading_widget.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/new_task_floating_button.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/task_card.dart';
import 'package:todo_list/injection_container.dart';

class TodayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today'),
      ),
      drawer: SideMenuDrawer(),
      floatingActionButton: NewTaskFloatingButton(route: '/today'),
      body: buildBody(context),
    );
  }

  BlocProvider<TodoListBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TodoListBloc>(),
      child: BlocBuilder<TodoListBloc, TodoListState>(
        builder: (context, state) {
          if (state is Empty) {
            BlocProvider.of<TodoListBloc>(context).add(GetTodaysTasksEvent());
            return LoadingWidget();
          } else if (state is Loading) {
            return LoadingWidget();
          } else if (state is AllTodaysTasksState) {
            if (state.tasksList?.isEmpty ?? true) {
              return DisplayMessage(message: 'You are all done!');
            } else {
              return _buildTasksList(context, state.tasksList);
            }
          } else {
            BlocProvider.of<TodoListBloc>(context).add(GetTodaysTasksEvent());
            return LoadingWidget();
          }
        },
      ),
    );
  }

  ListView _buildTasksList(BuildContext context, List<TodoTask> tasks) {
    List<Widget> tasksList = [];
    tasks.forEach((task) {
      tasksList.add(TaskCard(task: task, route: '/'));
    });
    return ListView(
      children: tasksList,
    );
  }
}
