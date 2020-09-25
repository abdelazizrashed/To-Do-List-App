part of 'todo_list_bloc.dart';

abstract class TodoListState extends Equatable {
  const TodoListState();

  @override
  List<Object> get props => [];
}

class Empty extends TodoListState {}

class Loading extends TodoListState {}

class AllCompletedTasksState extends TodoListState {
  final List<TodoTask> tasksList;

  AllCompletedTasksState(this.tasksList);
}

class AllUnfinishedTasksState extends TodoListState {
  final List<TodoTask> tasksList;

  AllUnfinishedTasksState(this.tasksList);
}

class AllProjectsUnfinishedTasksState extends TodoListState {
  final TodoProject project;
  final List<TodoTask> tasksList;

  AllProjectsUnfinishedTasksState({
    @required this.project,
    @required this.tasksList,
  });
}

class AllProjectsCompletedTasksState extends TodoListState {
  final TodoProject project;
  final List<TodoTask> tasksList;

  AllProjectsCompletedTasksState({
    @required this.project,
    @required this.tasksList,
  });
}

class AllTodaysTasksState extends TodoListState{
  final List<TodoTask> tasksList;

  AllTodaysTasksState(this.tasksList);
}

class AllProjectsState extends TodoListState {
  final List<TodoProject> projectsList;

  AllProjectsState(this.projectsList);
}

class AllTagsState extends TodoListState {
  final List<TodoTag> tagsList;

  AllTagsState(this.tagsList);
}

class Error extends TodoListState {
  final String message;

  Error(this.message);
}
