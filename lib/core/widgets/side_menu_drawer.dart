import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/utilities/todo_project2project_tree_converter.dart';
import 'package:todo_list/core/widgets/custom_expansion_tile.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';
import 'package:todo_list/features/todo_list/presentation/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/display_message.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/loading_widget.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/new_project_input_field.dart';
import 'package:todo_list/injection_container.dart';

class SideMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TodoListBloc>(),
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Abdelaziz'),
              accountEmail: Text('test@gmail.com'),
              currentAccountPicture: Placeholder(),
            ),
            buildUpcomingTile(context),
            buildTodayTile(context),
            buildProjectsTiles(context),
            buildHistoryTile(context),
          ],
        ),
      ),
    );
  }

  ListTile buildUpcomingTile(BuildContext context) {
    return ListTile(
      title: Text(
        'Upcoming',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      leading: Icon(Icons.av_timer),
      onTap: () {
        Navigator.popUntil(context, ModalRoute.withName('/'));
        Navigator.pushNamed(context, '/');
      },
    );
  }

  ListTile buildHistoryTile(BuildContext context) {
    return ListTile(
      title: Text(
        'History',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      leading: Icon(Icons.history),
      onTap: () {
        Navigator.popUntil(context, ModalRoute.withName('/'));
        Navigator.pushNamed(context, '/history');
      },
    );
  }

  ListTile buildTodayTile(BuildContext context) {
    return ListTile(
      title: Text(
        'Today',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      leading: Icon(Icons.today),
      onTap: () {
        Navigator.popUntil(context, ModalRoute.withName('/today'));
        Navigator.pushNamed(context, '/today');
      },
    );
  }

  Row buildProjectsTiles(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              dividerTheme: DividerThemeData(
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            child: Builder(
              builder: (context) {
                return BlocBuilder<TodoListBloc, TodoListState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state is Empty) {
                      BlocProvider.of<TodoListBloc>(context)
                          .add(GetAllProjectsEvent());
                      return LoadingWidget();
                    } else if (state is Loading) {
                      return LoadingWidget();
                    } else if (state is AllProjectsState) {
                      if (state.projectsList?.isNotEmpty ?? false) {
                        List<TodoProject> parentsList = state.projectsList
                            .where((project) => project.parentProject == null)
                            .toList();
                        List<ProjectTree> projectTrees = buildParentsTree(
                            parentsList: parentsList,
                            projectsList: state.projectsList);
                        List<CustomExpansionTile> tilesList =
                            _getExpansionTilesFromProjecTrees(
                                context, projectTrees);
                        return _buildProjectsExpansioTile(tilesList);
                      }
                    } else if (state is Error) {
                      return DisplayMessage(message: state.message);
                    } else {
                      BlocProvider.of<TodoListBloc>(context)
                          .add(GetAllProjectsEvent());
                      return _buildProjectsExpansioTile([]);
                    }
                  },
                );
              },
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
            Navigator.pushNamed(context, '/');

            showGeneralDialog(
              barrierLabel: "Label",
              barrierDismissible: true,
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: Duration(milliseconds: 700),
              context: context,
              pageBuilder: (context, anim, _) {
                return NewProjectInputField(route: '/');
              },
              transitionBuilder: (context, anim1, anim2, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 1),
                    end: Offset(0, 0),
                  ).animate(anim1),
                  child: child,
                );
              },
            );
          },
        ),
      ],
    );
  }

  ExpansionTile _buildProjectsExpansioTile(
      List<CustomExpansionTile> tilesList) {
    return ExpansionTile(
      title: Text(
        'Projects',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      leading: Icon(Icons.format_list_bulleted),
      children: tilesList,
    );
  }

  ///Use recursion to build a tree of CustomExpansionTiles
  List<CustomExpansionTile> _getExpansionTilesFromProjecTrees(
      BuildContext context, List<ProjectTree> projectTrees) {
    List<CustomExpansionTile> expansionTiles = [];
    projectTrees.forEach((projectTree) {
      expansionTiles.add(CustomExpansionTile(
        title: Text(projectTree.parent.projectName),
        onTap: () {
          Navigator.popUntil(context, ModalRoute.withName('/'));
          Navigator.pushNamed(context, '/projectsTasks',
              arguments: projectTree.parent);
        },
        children: projectTree.children?.isNotEmpty ?? false
            ? _getExpansionTilesFromProjecTrees(context, projectTree.children)
            : [],
      ));
    });
    return expansionTiles;
  }
}
