import 'package:get_it/get_it.dart';
import 'package:todo_list/features/todo_list/data/data_sources/moor_database.dart';
import 'package:todo_list/features/todo_list/data/repositories/todo_list_repository_impl.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';
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
import 'package:todo_list/features/todo_list/domain/use_cases/get_todays_tasks.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/modify_tag.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/modify_task.dart';
import 'package:todo_list/features/todo_list/presentation/bloc/todo_list_bloc.dart';

final sl = GetIt.instance; //service locator

Future<void> init() async {
  //! Features - Todo List
  initTodoListFeature();
}

void initTodoListFeature() {
  //BLoC
  sl.registerFactory(() => TodoListBloc(
        addTask: sl(),
        getAllCompletedTasks: sl(),
        getAllUnfinishedTasks: sl(),
        getProjectsCompletedTasks: sl(),
        getProjectsUnfinishedTasks: sl(),
        getTodaysTasks: sl(),
        modifyTask: sl(),
        deleteTask: sl(),
        addTag: sl(),
        getAllTags: sl(),
        modifyTag: sl(),
        deleteTag: sl(),
        addProject: sl(),
        getAllProjects: sl(),
        deleteProject: sl(),
      ));

  //Use cases
  sl.registerLazySingleton(() => AddTask(sl()));
  sl.registerLazySingleton(() => GetAllUnfinishedTasks(sl()));
  sl.registerLazySingleton(() => GetAllCompletedTasks(sl()));
  sl.registerLazySingleton(() => GetProjectsCompletedTasks(sl()));
  sl.registerLazySingleton(() => GetProjectsUnfinishedTasks(sl()));
  sl.registerLazySingleton(() => GetTodaysTasks(sl()));
  sl.registerLazySingleton(() => ModifyTask(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));
  sl.registerLazySingleton(() => AddTag(sl()));
  sl.registerLazySingleton(() => GetAllTags(sl()));
  sl.registerLazySingleton(() => ModifyTag(sl()));
  sl.registerLazySingleton(() => DeleteTag(sl()));
  sl.registerLazySingleton(() => AddProject(sl()));
  sl.registerLazySingleton(() => GetAllProjects(sl()));
  sl.registerLazySingleton(() => DeleteProject(sl()));

  //Repository
  sl.registerLazySingleton<TodoListRepository>(() => TodoListRepositoryImpl(
        db: sl(),
        taskDao: sl(),
        tagDao: sl(),
        projectDao: sl(),
      ));

  //Data base
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
  sl.registerLazySingleton<TaskDao>(() => TaskDao(sl()));
  sl.registerLazySingleton<TagDao>(() => TagDao(sl()));
  sl.registerLazySingleton<ProjectDao>(() => ProjectDao(sl()));
}
