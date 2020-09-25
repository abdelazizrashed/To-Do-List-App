import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_tag.dart';
import 'package:todo_list/features/todo_list/presentation/bloc/todo_list_bloc.dart';
import 'package:todo_list/injection_container.dart';

class NewTagInputField extends StatefulWidget {
  final String route;

  const NewTagInputField({Key key, @required this.route}) : super(key: key);
  @override
  _NewTagInputFieldState createState() => _NewTagInputFieldState(route);
}

class _NewTagInputFieldState extends State<NewTagInputField> {
  static const Color DEFAULT_COLOR = Colors.blue;
  final String route;
  TextEditingController controller;
  String newTagName;

  Color newTagColor = DEFAULT_COLOR;

  _NewTagInputFieldState(this.route);

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
                          hintText: 'Tag Name',
                        ),
                        onChanged: (value) {
                          newTagName = value;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FlatButton.icon(
                        onPressed: () {
                          _showColorPickerDialog(providerContext);
                        },
                        label: Text('Choose color'),
                        icon: Icon(Icons.color_lens),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          if (newTagName?.isEmpty ?? true) {
                            return showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                    content:
                                        Text('Tag name should not be empty')));
                          }
                          _submitNewTag(providerContext);
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

  Future _showColorPickerDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: MaterialColorPicker(
            selectedColor: DEFAULT_COLOR,
            onMainColorChange: (color) {
              newTagColor = color;
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  void _submitNewTag(BuildContext context) {
    TodoTag newTag = TodoTag(
      tagName: newTagName,
      tagColor: newTagColor.value,
    );

    BlocProvider.of<TodoListBloc>(context).add(AddTagEvent(newTag));
  }

  void _resetValuesAfterSubmit() {
    newTagName = null;
    newTagColor = null;
    controller.clear();
  }
}
