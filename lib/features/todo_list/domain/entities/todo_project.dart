import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class TodoProject extends Equatable{
  final String projectName;
  final TodoProject parentProject;

  TodoProject({@required this.projectName, this.parentProject});

  @override
  List<Object> get props => [projectName, parentProject];

}