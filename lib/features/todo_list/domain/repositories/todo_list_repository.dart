import 'package:dartz/dartz.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_tag.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_task.dart';

abstract class TodoListRepository {
  //*Tasks
  ///Gets all the tasks in the database which have the completed variable is false
  Future<Either<Failure, List<TodoTask>>> getAllUnfinishedTasks();

  ///Gets all the tasks from the database where the completed variable is true
  Future<Either<Failure, List<TodoTask>>> getAllCompletedTasks();

  ///Gets all the unfinished task for a specific project
  Future<Either<Failure, List<TodoTask>>> getProjectsUnfinishedTasks(
      TodoProject project);

  ///Gets all the completed tasks for a specific project
  Future<Either<Failure, List<TodoTask>>> getProjectsCompletedTasks(
      TodoProject project);

  ///Gets all the tasks that are due today
  Future<Either<Failure, List<TodoTask>>> getTodaysTasks();

  ///Add a task to the tasks lists
  Future<Either<Failure, void>> addTask(TodoTask task);

  ///Modify an existing task
  ///It will use the update task function of the database.
  ///It will be used mainly to change the status of the task from unfinished to completed.
  Future<Either<Failure, void>> modifyTask(TodoTask task);

  ///Delete an existing task
  Future<Either<Failure, void>> deleteTask(TodoTask task);

  //*tags
  ///Returns a list of all the tags from the database
  Future<Either<Failure, List<TodoTag>>> getAllTags();

  ///Add a tag to the tasks lists
  Future<Either<Failure, void>> addTag(TodoTag tag);

  ///Modify an existing tag
  ///It will use the updateTag function of the database.
  ///It will be used mainly to change the color of the tag.
  Future<Either<Failure, void>> modifyTag(TodoTag tag);

  ///Delete an existing tag
  Future<Either<Failure, void>> deleteTag(TodoTag tag);

  //*Projects
  ///Returns a list of all the projects from the database
  Future<Either<Failure, List<TodoProject>>> getAllProjects();

  ///Add a project to the projects lists
  Future<Either<Failure, void>> addProject(TodoProject project );

  ///Delete an existing Project
  Future<Either<Failure, void>> deleteProject(TodoProject project);
}
