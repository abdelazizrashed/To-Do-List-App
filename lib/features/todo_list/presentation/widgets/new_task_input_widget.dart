import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_tag.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_task.dart';
import 'package:todo_list/features/todo_list/presentation/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/display_message.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/loading_widget.dart';
import 'package:todo_list/injection_container.dart';

class NewTaskInputWidget extends StatefulWidget {
  final String route;

  const NewTaskInputWidget({Key key, @required this.route}) : super(key: key);
  @override
  _NewTaskInputWidgetState createState() => _NewTaskInputWidgetState(route);
}

class _NewTaskInputWidgetState extends State<NewTaskInputWidget> {
  final String route;
  TextEditingController controller;
  String newTaskName;
  TodoProject newTaskProject;
  TodoTag newTaskTag;
  DateTime newTaskDueDate;

  _NewTaskInputWidgetState(this.route);

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TodoListBloc>(),
      child: Builder(
        builder: (providerContext) {
          return Align(
            child: Container(
              height: 250,
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Card(
                  elevation: 0,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Colors.grey)),
                          hintText: 'Task Name',
                        ),
                        onChanged: (value) {
                          newTaskName = value;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          _buildDueDateButton(context),
                          _buildTagButton(context),
                          _buildProjectButton(context),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      //Todo: Implement the button so that when it is clicked it will go out of the routes and submit the new task
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          if (newTaskName?.isEmpty ?? true) {
                            return showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                    content:
                                        Text('Task name should not be empty')));
                          }
                          _addNewTask(providerContext);
                          _resetValuesAfterSubmit();
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                          if (route == '/') {
                            Navigator.pushNamed(context, '/');
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  ///Returns an IconButton. This button is used to open a date picker
  ///and allows the user to choose the due date of the task.
  IconButton _buildDueDateButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add_alert),
      onPressed: () async {
        newTaskDueDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2015),
            lastDate: DateTime(2050));
      },
    );
  }

  ///Returns an IconButton. This button will be used to choose the tag of the task.
  ///When the user clicks the button a dialog with all the tags will appear as well as
  ///a button for the user to add tag which will route him to add new tag.
  IconButton _buildTagButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.flag),
      onPressed: () {
        showGeneralDialog(
          barrierLabel: "Label",
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 700),
          context: context,
          pageBuilder: (context, anim1, anim2) {
            return Dialog(
              child: Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: BlocProvider(
                        create: (context) => sl<TodoListBloc>(),
                        child: BlocBuilder<TodoListBloc, TodoListState>(
                          builder: (context, state) {
                            if (state is Empty) {
                              BlocProvider.of<TodoListBloc>(context)
                                  .add(GetAllTagsEvent());
                              return DisplayMessage(
                                message: 'State is empty',
                                fontSize: 25,
                              );
                            } else if (state is Loading) {
                              return LoadingWidget();
                            } else if (state is AllTagsState) {
                              if (state.tagsList.length == 0) {
                                return DisplayMessage(
                                  message: 'No Tags!\nAdd a new tag',
                                  fontSize: 25,
                                );
                              } else {
                                return _buildTagDialogCards(
                                    context, state.tagsList);
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    //Todo: Implement on pressed function so that pops all pages and navigate to add new tag page
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  ///Takes a list of tags and return a ListView widget which contain
  ///a list cards. These cards represent the tags and have an event which will change
  ///the newTaskTag variable to the chosen tag.
  ListView _buildTagDialogCards(BuildContext context, List<TodoTag> tags) {
    List<Widget> tagCards = [];

    tags.forEach((element) {
      tagCards.add(
        Card(
          child: ListTile(
            title: Text(element.tagName),
            leading: Icon(
              Icons.flag,
              color: Color(element.tagColor),
            ),
            onTap: () {
              newTaskTag = element;
              print(newTaskTag.tagName);
              Navigator.of(context).pop();
            },
          ),
        ),
      );
    });
    return ListView(
      children: tagCards,
    );
  }

  ///Returns an IconButton. This button will be used to open a dialog in which
  ///the user can choose a project from the projects available or add new project
  IconButton _buildProjectButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.format_list_bulleted),
      onPressed: () {
        showGeneralDialog(
          barrierLabel: "Label",
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 700),
          context: context,
          pageBuilder: (context, anim1, anim2) {
            return Dialog(
              child: Container(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: BlocProvider(
                        create: (context) => sl<TodoListBloc>(),
                        child: BlocBuilder<TodoListBloc, TodoListState>(
                          builder: (context, state) {
                            if (state is Empty) {
                              BlocProvider.of<TodoListBloc>(context)
                                  .add(GetAllProjectsEvent());
                              return DisplayMessage(
                                message: 'State is empty',
                                fontSize: 25,
                              );
                            } else if (state is Loading) {
                              return LoadingWidget();
                            } else if (state is AllProjectsState) {
                              if (state.projectsList.length == 0) {
                                return DisplayMessage(
                                  message: 'No Projects!\nAdd a new Project',
                                  fontSize: 25,
                                );
                              } else {
                                return _buildProjectDialogCards(
                                    context, state.projectsList);
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    //Todo: Implement on pressed function so that pops all pages and navigate to add new project page
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  ListView _buildProjectDialogCards(
      BuildContext context, List<TodoProject> projects) {
    List<Widget> projectCards = [];

    projects.forEach((element) {
      projectCards.add(
        Card(
          child: ListTile(
            title: Text(element.projectName),
            onTap: () {
              newTaskProject = element;
              Navigator.of(context).pop();
            },
          ),
        ),
      );
    });
    return ListView(
      children: projectCards,
    );
  }

  void _addNewTask(BuildContext context) {
    TodoTask newTask = TodoTask(
      taskName: newTaskName,
      dueDate: newTaskDueDate,
      tag: newTaskTag,
      project: newTaskProject,
      completed: false,
    );
    BlocProvider.of<TodoListBloc>(context).add(AddTaskEvent(newTask));
    BlocProvider.of<TodoListBloc>(context).add(GetAllUnfinishedTasksEvent());
    print('send get unfinished events to bloc');
  }

  void _resetValuesAfterSubmit() {
    newTaskName = null;
    newTaskDueDate = null;
    newTaskProject = null;
    newTaskTag = null;
    controller.clear();
  }
}
