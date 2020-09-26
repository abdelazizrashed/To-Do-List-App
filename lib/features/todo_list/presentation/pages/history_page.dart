import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/widgets/side_menu_drawer.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_task.dart';
import 'package:todo_list/features/todo_list/presentation/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/display_message.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/finished_task_card.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/loading_widget.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/new_task_floating_button.dart';
import 'package:todo_list/injection_container.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      drawer: SideMenuDrawer(),
      body: buildBody(context),
      floatingActionButton: NewTaskFloatingButton(
        route: '/history',
      ),
    );
  }

  BlocProvider<TodoListBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TodoListBloc>(),
      child: BlocBuilder<TodoListBloc, TodoListState>(
        builder: (context, state) {
          if (state is Empty) {
            BlocProvider.of<TodoListBloc>(context)
                .add(GetAllCompletedTasksEvent());
            return LoadingWidget();
          } else if (state is Loading) {
            return LoadingWidget();
          } else if (state is AllCompletedTasksState) {
            print(state.tasksList?.length ?? 'task list is empty');
            if (state.tasksList?.isEmpty ?? true) {
              return DisplayMessage(
                  message: 'You haven\'t finished any tasks yet');
            } else {
              return buildTasksList(context, state.tasksList);
            }
          } else if (state is Error) {
            return DisplayMessage(message: state.message);
          } else {
            BlocProvider.of<TodoListBloc>(context)
                .add(GetAllCompletedTasksEvent());
            return LoadingWidget();
          }
        },
      ),
    );
  }

  ListView buildTasksList(BuildContext context, List<TodoTask> tasks) {
    List<Widget> tasksList = [];
    tasks.forEach((task) {
      tasksList.add(FinishedTaskCard(task: task));
    });
    return ListView(
      children: tasksList,
    );
  }
}
