import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/features/todo_list/data/data_sources/moor_database.dart'
    as moor;
import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_tag.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_task.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';

class TodoListRepositoryImpl implements TodoListRepository {
  final moor.AppDatabase db;
  final moor.TaskDao taskDao;
  final moor.TagDao tagDao;
  final moor.ProjectDao projectDao;

  TodoListRepositoryImpl({
    @required this.db,
    @required this.taskDao,
    @required this.tagDao,
    @required this.projectDao,
  });

  @override
  Future<Either<Failure, List<TodoTask>>> getAllCompletedTasks() async {
    try {
      List<moor.Task> tasksList = await taskDao.getAllCompletedTasks();
      List<TodoTask> todoTasksList =
          await convertTaskList2TodoTaskList(tasksList);
      return Right(todoTasksList);
    } catch (e) {
      return Left(LocalDataFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoTask>>> getAllUnfinishedTasks() async {
    try {
      List<moor.Task> tasksList = await taskDao.getAllUnfinishedTasks();
      List<TodoTask> todoTasksList =
          await convertTaskList2TodoTaskList(tasksList);
      return Right(todoTasksList);
    } catch (e) {
      return Left(LocalDataFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoTask>>> getProjectsCompletedTasks(
      TodoProject project) async {
    try {
      List<moor.Task> tasksList =
          await taskDao.getProjectsCompletedTasks(project);
      List<TodoTask> todoTasksList = 
          await convertTaskList2TodoTaskList(tasksList);
      return Right(todoTasksList);
    } catch (e) {
      return Left(LocalDataFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoTask>>> getProjectsUnfinishedTasks(
      TodoProject project) async {
    try {
      List<moor.Task> tasksList =
          await taskDao.getProjectsUnfinishedTasks(project);
      List<TodoTask> todoTasksList =
          await convertTaskList2TodoTaskList(tasksList);
      return Right(todoTasksList);
    } catch (e) {
      return Left(LocalDataFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoTask>>> getTodaysTasks() async {
    try {
      List<moor.Task> tasksList = await taskDao.getTodaysTasks();
      List<TodoTask> todoTasksList = 
          await convertTaskList2TodoTaskList(tasksList);
      return Right(todoTasksList);
    } catch (e) {
      return Left(LocalDataFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addProject(TodoProject project) async {
    try {
      return projectDao.insertProject(convertTodoProject2Project(project));
    } catch (e) {
      return Left(LocalDataFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addTag(TodoTag tag) async {
    try {
      return tagDao.insertTag(convertTodoTag2Tag(tag));
    } catch (e) {
      return Left(LocalDataFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addTask(TodoTask task) async {
    try {
      await taskDao.insertTask(convertTodoTask2Task(task));
      return null;
    } catch (e) {
      return Left(LocalDataFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(TodoProject project) async {
    try {
      return projectDao.deleteProject(convertTodoProject2Project(project));
    } catch (e) {
      return Left(LocalDataFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTag(TodoTag tag) async {
    try {
      return tagDao.deleteTag(convertTodoTag2Tag(tag));
    } catch (e) {
      return Left(LocalDataFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(TodoTask task) async {
    try {
      return await taskDao.deleteTask(convertTodoTask2Task(task));
    } catch (e) {
      return Left(LocalDataFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoProject>>> getAllProjects() async {
    try {
      List<moor.Project> projectsList = await projectDao.getAllProjects();
      List<TodoProject> todoProjectsList = [];
      for (var i = 0; i < projectsList.length; i++) {
        todoProjectsList.add(await convertProject2TodoProject(projectsList[i]));
      }
      return Right(todoProjectsList);
    } catch (e) {
      return Left(LocalDataFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoTag>>> getAllTags() async {
    try {
      List<moor.Tag> tagsList = await tagDao.getAllTags();
      List<TodoTag> todoTagsList = [];
      for (var i = 0; i < tagsList.length; i++) {
        todoTagsList.add(convertTag2TodoTag(tagsList[i]));
      }
      return Right(todoTagsList);
    } catch (e) {
      return Left(LocalDataFailure());
    }
  }

  @override
  Future<Either<Failure, void>> modifyTag(TodoTag tag) async {
    try {
      return tagDao
          .updateTag(moor.Tag(tagName: tag.tagName, color: tag.tagColor));
    } catch (e) {
      return Left(LocalDataFailure());
    }
  }

  @override
  Future<Either<Failure, void>> modifyTask(TodoTask task) async {
    try {
      return taskDao.updateTask(convertTodoTask2Task(task));
    } catch (e) {
      return Left(LocalDataFailure());
    }
  }

  //! Convertions
  ///Takes a Task object that is defined in the moor_database file and change it to the entity TodoTask
  Future<TodoTask> convertTask2TodoTask(moor.Task task) async {
    moor.Tag tag;
    moor.Project project;
    if (task.tagName != null) {
      tag = await tagDao.getTagByName(task.tagName);
    } else {
      tag = null;
    }
    if (task.projectName != null) {
      project = await projectDao.getProjectByName(task.projectName);
    } else {
      project = null;
    }
    return TodoTask(
      id: task.id,
      completed: task.completed,
      taskName: task.taskName,
      dueDate: task.dueDate,
      tag: (tag != null) ? convertTag2TodoTag(tag) : null,
      project:
          (project != null) ? await convertProject2TodoProject(project) : null,
    );
  }

  ///Takes a Tag object that is defined in the moor_database file and change it to the entity TodoTag
  TodoTag convertTag2TodoTag(moor.Tag tag) {
    return TodoTag(tagName: tag.tagName, tagColor: tag.color);
  }

  /// Takes a Project object and change it to TodoProject entity
  Future<TodoProject> convertProject2TodoProject(moor.Project project) async {
    TodoProject parent;
    if (project.parentName != null) {
      parent = await convertProject2TodoProject(
          await projectDao.getProjectByName(project.parentName));
    } else {
      parent = null;
    }
    return TodoProject(projectName: project.projectName, parentProject: parent);
  }

  moor.Task convertTodoTask2Task(TodoTask task) {
    return moor.Task(
      id: task.id,
      taskName: task.taskName,
      dueDate: task.dueDate,
      completed: task.completed,
      tagName: (task.tag != null) ? task.tag.tagName : null,
      projectName: (task.project != null) ? task.project.projectName : null,
    );
  }

  moor.Tag convertTodoTag2Tag(TodoTag tag) {
    return moor.Tag(
      tagName: tag.tagName,
      color: tag.tagColor,
    );
  }

  moor.Project convertTodoProject2Project(TodoProject project) {
    return moor.Project(
      projectName: project.projectName,
      parentName: (project.parentProject != null)
          ? project.parentProject.projectName
          : null,
    );
  }

  Future<List<TodoTask>> convertTaskList2TodoTaskList(List<moor.Task> tasksList) async {
    List<TodoTask> todoTasksList = [];
    for (var i = 0; i < tasksList.length; i++) {
      todoTasksList.add(await convertTask2TodoTask(tasksList[i]));
    }
    return todoTasksList;
  }
}
