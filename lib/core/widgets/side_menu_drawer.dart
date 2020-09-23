import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo_list/presentation/bloc/todo_list_bloc.dart';
import 'package:todo_list/injection_container.dart';

class SideMenuDrawer extends StatefulWidget {
  @override
  _SideMenuDrawerState createState() => _SideMenuDrawerState();
}

class _SideMenuDrawerState extends State<SideMenuDrawer> {
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
            ListTile(
              title: Text('Upcomming'),
              leading: Icon(Icons.av_timer),
              onTap: (){
                Navigator.popUntil(context, ModalRoute.withName('/'));
                BlocProvider.of<TodoListBloc>(context).add(GetAllUnfinishedTasksEvent());
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
