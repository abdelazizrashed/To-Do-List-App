import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';
import 'package:todo_list/features/todo_list/presentation/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/display_message.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/loading_widget.dart';
import 'package:todo_list/injection_container.dart';

class NewProjectInputField extends StatefulWidget {
  final String route;

  const NewProjectInputField({Key key, @required this.route}) : super(key: key);
  @override
  _NewProjectInputFieldState createState() => _NewProjectInputFieldState(route);
}

class _NewProjectInputFieldState extends State<NewProjectInputField> {
  final String route;
  TextEditingController controller;
  String newProjectName;
  TodoProject newProjectParentProject;
  _NewProjectInputFieldState(this.route);

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
                        controller: controller,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Colors.grey)),
                          hintText: 'Project Name',
                        ),
                        onChanged: (value) {
                          newProjectName = value;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FlatButton.icon(
                        onPressed: () {
                          _showPorojectPickerDialog(context);
                        },
                        label: Text('Choose parent project'),
                        icon: Icon(Icons.format_list_bulleted),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          if (newProjectName?.isEmpty ?? true) {
                            return showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                    content: Text(
                                        'Project name should not be empty')));
                          }
                          _submitNewProject(providerContext);
                          _resetValuesAfterSubmit();
                          //navigation to the route it cam from so that it builds the page again
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                          Navigator.pushNamed(context, route);
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

  Future _showPorojectPickerDialog(BuildContext context) {
    return showGeneralDialog(
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
              ],
            ),
          ),
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
              newProjectParentProject = element;
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

  void _submitNewProject(BuildContext context) {
    TodoProject newProject = TodoProject(
      projectName: newProjectName,
      parentProject: newProjectParentProject,
    );

    BlocProvider.of<TodoListBloc>(context).add(AddProjectEvent(newProject));
  }

  void _resetValuesAfterSubmit() {
    newProjectName = null;
    newProjectParentProject = null;
    controller.clear();
  }
}
