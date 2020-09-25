import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/utilities/todo_project2project_tree_converter.dart';
import 'package:todo_list/core/widgets/custom_expansion_tile.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';
import 'package:todo_list/features/todo_list/presentation/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/loading_widget.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/new_project_input_field.dart';
import 'package:todo_list/injection_container.dart';

class SideMenuDrawer extends StatefulWidget {
  @override
  _SideMenuDrawerState createState() => _SideMenuDrawerState();
}

class _SideMenuDrawerState extends State<SideMenuDrawer> {
  @override
  Widget build(BuildContext context) {
    List<CustomExpansionTile> expansionTilesList = [];

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
            ListTile(
              title: Text(
                'Upcomming',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              leading: Icon(Icons.av_timer),
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
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
            ),
            Row(
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
                          builder: (context, state) {
                            print('bloc listner is trigered');
                            if (state is Empty) {
                              print('emptyState is added');
                              BlocProvider.of<TodoListBloc>(context)
                                  .add(GetAllProjectsEvent());
                              return LoadingWidget();
                            } else if (state is AllProjectsState) {
                              print('AllProjectsState is added');
                              if (state.projectsList?.isNotEmpty ?? false) {
                                print('project list is not empty');
                                List<TodoProject> parentsList = state
                                    .projectsList
                                    .where((project) =>
                                        project.parentProject == null)
                                    .toList();
                                List<ProjectTree> projectTrees =
                                    buildParentsTree(
                                        parentsList: parentsList,
                                        projectsList: state.projectsList);
                                printProjectTree(projectTrees);
                                List<CustomExpansionTile> tilesList =
                                    _getExpansionTilesFromProjecTrees(
                                        projectTrees);
                                return _buildProjectsExpansioTile(tilesList);
                              }
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
            )
          ],
        ),
      ),
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

  ///Use recursion to build a tree of CustomExpantionTiles
  List<CustomExpansionTile> _getExpansionTilesFromProjecTrees(
      List<ProjectTree> projectTrees) {
    print('getExpansionTilesFromProejctTrees is triggered');
    List<CustomExpansionTile> expansionTiles = [];
    projectTrees.forEach((projectTree) {
      expansionTiles.add(CustomExpansionTile(
        title: Text(projectTree.parent.projectName),
        //Todo: implement an event to happen when ressing the name of the project to route the app to a template page that takes project as prameter
        onTap: () {
          print(projectTree.parent.projectName);
        },
        children: projectTree.children?.isNotEmpty ?? false
            ? _getExpansionTilesFromProjecTrees(projectTree.children)
            : [],
      ));
    });
    return expansionTiles;
  }
}
