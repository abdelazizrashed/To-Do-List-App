import 'package:flutter/material.dart';
import 'package:todo_list/features/todo_list/presentation/widgets/new_task_input_widget.dart';

class NewTaskFloatingButton extends StatelessWidget {
  final String route;

  const NewTaskFloatingButton({Key key, @required this.route}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showGeneralDialog(
            barrierLabel: "Label",
            barrierDismissible: true,
            barrierColor: Colors.black.withOpacity(0.5),
            transitionDuration: Duration(milliseconds: 700),
            context: context,
            pageBuilder: (context, anim, _) {
              return NewTaskInputWidget(route: route,);
            },
            transitionBuilder: (context, anim1, anim2, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, 1),
                  end: Offset(0, 0),
                ).animate(anim1),
                child: child,
              );
            });
      },
    );
  }
}
