import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/core/error/error_messages.dart';
import 'package:todo_list/core/use_cases/use_case.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_tag.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_task.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/add_project.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/add_tag.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/add_task.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/delete_project.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/delete_tag.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/delete_task.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/get_all_completed_tasks.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/get_all_projects.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/get_all_tags.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/get_all_unfinished_tasks.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/get_projects_completed_tasks.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/get_projects_unfinished_tasks.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/modify_tag.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/modify_task.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  final AddTask addTask;
  final GetAllCompletedTasks getAllCompletedTasks;
  final GetAllUnfinishedTasks getAllUnfinishedTasks;
  final GetProjectsCompletedTasks getProjectsCompletedTasks;
  final GetProjectsUnfinishedTasks getProjectsUnfinishedTasks;
  final ModifyTask modifyTask;
  final DeleteTask deleteTask;
  final AddTag addTag;
  final GetAllTags getAllTags;
  final ModifyTag modifyTag;
  final DeleteTag deleteTag;
  final AddProject addProject;
  final GetAllProjects getAllProjects;
  final DeleteProject deleteProject;

  TodoListBloc({
    @required this.addTask,
    @required this.getAllCompletedTasks,
    @required this.getAllUnfinishedTasks,
    @required this.getProjectsCompletedTasks,
    @required this.getProjectsUnfinishedTasks,
    @required this.modifyTask,
    @required this.deleteTask,
    @required this.addTag,
    @required this.getAllTags,
    @required this.modifyTag,
    @required this.deleteTag,
    @required this.addProject,
    @required this.getAllProjects,
    @required this.deleteProject,
  })  : assert(addTask != null),
        assert(getAllCompletedTasks != null),
        assert(getAllUnfinishedTasks != null),
        assert(getProjectsCompletedTasks != null),
        assert(getProjectsUnfinishedTasks != null),
        assert(modifyTask != null),
        assert(deleteTask != null),
        assert(addTag != null),
        assert(getAllTags != null),
        assert(modifyTag != null),
        assert(deleteTag != null),
        assert(addProject != null),
        assert(getAllProjects != null),
        assert(deleteProject != null),
        super(Empty());

  @override
  Stream<TodoListState> mapEventToState(
    TodoListEvent event,
  ) async* {
    if (event is AddTaskEvent) {
      await addTask(event.task);
    } else if (event is ModifyTaskEvent) {
      await modifyTask(event.task);
    } else if (event is DeleteTaskEvent) {
      await deleteTask(event.task);
    } else if (event is AddTagEvent) {
      await addTag(event.tag);
    } else if (event is ModifyTagEvent) {
      await modifyTag(event.tag);
    } else if (event is DeleteTagEvent) {
      await deleteTag(event.tag);
    } else if (event is AddProjectEvent) {
      await addProject(event.project);
    } else if (event is DeleteProjectEvent) {
      await deleteProject(event.project);
    } else if (event is GetAllUnfinishedTasksEvent) {
      yield Loading();
      final tasksEither = await getAllUnfinishedTasks(NoParams());
      yield* tasksEither.fold(
        (failure) async* {
          yield Error(LOCAL_DATA_ERROR);
        },
        (value) async* {
          yield AllUnfinishedTasksState(value);
        },
      );
    } else if (event is GetAllCompletedTasksEvent) {
      yield Loading();
      final tasksEither = await getAllCompletedTasks(NoParams());
      yield* tasksEither.fold(
        (failure) async* {
          yield Error(LOCAL_DATA_ERROR);
        },
        (value) async* {
          yield AllCompletedTasksState(value);
        },
      );
    } else if (event is GetProjectsUnfinishedTasksEvent) {
      yield Loading();
      final tasksEither = await getProjectsUnfinishedTasks(event.project);
      yield* tasksEither.fold(
        (failure) async* {
          yield Error(LOCAL_DATA_ERROR);
        },
        (value) async* {
          yield AllProjectsUnfinishedTasksState(
              project: event.project, tasksList: value);
        },
      );
    } else if (event is GetProjectsCompletedTasksEvent) {
      yield Loading();
      final tasksEither = await getProjectsCompletedTasks(event.project);
      yield* tasksEither.fold(
        (failure) async* {
          yield Error(LOCAL_DATA_ERROR);
        },
        (value) async* {
          yield AllProjectsCompletedTasksState(
              project: event.project, tasksList: value);
        },
      );
    } else if (event is GetAllTagsEvent) {
      yield Loading();
      final tagsEither = await getAllTags(NoParams());
      yield* tagsEither.fold(
        (failure) async* {
          yield Error(LOCAL_DATA_ERROR);
        },
        (value) async* {
          yield AllTagsState(value);
        },
      );
    } else if (event is GetAllProjectsEvent) {
      
      yield Loading();
      final projectsEither = await getAllProjects(NoParams());
      yield* projectsEither.fold(
        (failure) async* {
          yield Error(LOCAL_DATA_ERROR);
        },
        (value) async* {
          yield AllProjectsState(value);
        },
      );
    }
  }
}
