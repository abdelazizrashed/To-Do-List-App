part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TodoListEvent {
  final TodoTask task;

  AddTaskEvent(this.task);
}

class GetAllUnfinishedTasksEvent extends TodoListEvent {}

class GetAllCompletedTasksEvent extends TodoListEvent {}

class GetProjectsUnfinishedTasksEvent extends TodoListEvent {
  final TodoProject project;

  GetProjectsUnfinishedTasksEvent(this.project);
}

class GetProjectsCompletedTasksEvent extends TodoListEvent {
  final TodoProject project;

  GetProjectsCompletedTasksEvent(this.project);
}

class GetTodaysTasksEvent extends TodoListEvent{}

class ModifyTaskEvent extends TodoListEvent {
  final TodoTask task;

  ModifyTaskEvent(this.task);
}

class DeleteTaskEvent extends TodoListEvent {
  final TodoTask task;

  DeleteTaskEvent(this.task);
}

class AddTagEvent extends TodoListEvent {
  final TodoTag tag;

  AddTagEvent(this.tag);
}

class GetAllTagsEvent extends TodoListEvent {}

class ModifyTagEvent extends TodoListEvent {
  final TodoTag tag;

  ModifyTagEvent(this.tag);
}

class DeleteTagEvent extends TodoListEvent {
  final TodoTag tag;

  DeleteTagEvent(this.tag);
}

class AddProjectEvent extends TodoListEvent {
  final TodoProject project;

  AddProjectEvent(this.project);
}

class GetAllProjectsEvent extends TodoListEvent {}

class DeleteProjectEvent extends TodoListEvent {
  final TodoProject project;

  DeleteProjectEvent(this.project);
}
