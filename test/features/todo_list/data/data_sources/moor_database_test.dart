import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:todo_list/features/todo_list/data/data_sources/moor_database.dart';
import 'package:todo_list/features/todo_list/data/repositories/todo_list_repository_impl.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';

void main() {
  TodoListRepositoryImpl repository;
  AppDatabase db;
  TaskDao taskDao;
  TagDao tagDao;
  ProjectDao projectDao;

  setUp(() {
    db = AppDatabase(executor: VmDatabase.memory());
    taskDao = TaskDao(db);
    tagDao = TagDao(db);
    projectDao = ProjectDao(db);
    repository = TodoListRepositoryImpl(
      db: db,
      taskDao: taskDao,
      tagDao: tagDao,
      projectDao: projectDao,
    );
  });

  group('TaskDao', () {
    //?variable for testing
    final taskUnfinished = Task(taskName: 'task unfinished', completed: false);
    final taskCompleted = Task(taskName: 'task completed', completed: true);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    final taskDueToday =
        Task(taskName: 'Task due today', completed: false, dueDate: today);
    final project = Project(projectName: 'test project');
    final taskWithProjectCompleted = Task(
        taskName: 'task with project completed',
        projectName: project.projectName,
        completed: true
        );
    final taskWithProjectUnfinished = Task(
        taskName: 'task with project unfinished ',
        projectName: project.projectName, 
        completed: false);

    //*insertTask
    test('should insert a task successfuly', () async {
      int id = await taskDao.insertTask(taskUnfinished);
      Task task = await taskDao.watchTaskWithId(id).first;

      expect(task.taskName, taskUnfinished.taskName);
    });

    //*getTaskWithId
    test('Should get the task that is inserted', () async {
      //arrang
      int id = await taskDao.insertTask(taskUnfinished);
      //act
      final result = await taskDao.getTaskWithId(id);
      //assert
      expect(result[0].taskName, taskUnfinished.taskName);
    });

    //*getAllUnfinishedTasks
    test(
        'Should return list of unfinished tasks when getAllUnfinishedTasks() get called ',
        () async {
      //arrang
      int id = await taskDao.insertTask(taskUnfinished);
      //act
      final result = await taskDao.getAllUnfinishedTasks();
      //assert
      expect(result, TypeMatcher<List<Task>>());
      expect(result[0].taskName, taskUnfinished.taskName);
      expect(result[0].id, id);
    });

    //*getAllCompletedTasks
    test(
        'Should return list of all the completed tasks when getAllCompletedTasks() is called',
        () async {
      //arrang
      int id = await taskDao.insertTask(taskCompleted);
      //act
      final result = await taskDao.getAllCompletedTasks();
      //assert
      expect(result, TypeMatcher<List<Task>>());
      expect(result[0].taskName, taskCompleted.taskName);
      expect(result[0].id, id);
    });

    //*getProjectsCompletedTasks
    test(
        'Should return list of all the completed tasks of a specific project when getProjectsCompletedTasks is called ',
        () async {
      //arrang
      await projectDao.insertProject(project);
      int id = await taskDao.insertTask(taskWithProjectCompleted);
      //act
      final todoProject = await repository.convertProject2TodoProject(project);
      final result = await taskDao.getProjectsCompletedTasks(todoProject);
      //assert
      expect(result, TypeMatcher<List<Task>>());
      expect(result[0].taskName, taskWithProjectCompleted.taskName);
      expect(result[0].id, id);
    });

    //*getProjectsUnfinishedTasks
    test('Should return list of the unfinished tasks of a specific project ',
        () async {
      //arrang
      await projectDao.insertProject(project);
      int id = await taskDao.insertTask(taskWithProjectUnfinished);
      //act
      final result = await taskDao.getProjectsUnfinishedTasks(
          await repository.convertProject2TodoProject(project));
      //assert
      expect(result, TypeMatcher<List<Task>>());
      expect(result[0].taskName, taskWithProjectUnfinished.taskName);
      expect(result[0].id, id);
    });

    //*getTodaysTasks
    test('Should return list of tasks that are due today', () async {
      //arrang
      int id = await taskDao.insertTask(taskDueToday);
      //act
      final result = await taskDao.getTodaysTasks();
      //assert
      expect(result, TypeMatcher<List<Task>>());
      expect(result[0].taskName, taskDueToday.taskName);
      expect(result[0].id, id);
    });

  });

  group('tagDao', () {
    final newTag = Tag(tagName: 'test tag', color: 4);

    //*insertTag
    test('Should insert a tag successfully', () async {
      //act
      await tagDao.insertTag(newTag);
      //assert
      Tag returnedTag = await tagDao.watchTagWithTagName(newTag.tagName).first;
      expect(returnedTag, newTag);
    });

    //*getAllTags
    test('Should get all tag in the data base successfully', () async {
      //arrang
      await tagDao.insertTag(newTag);
      //act
      final result = await tagDao.getAllTags();
      //assert
      expect(result[0], newTag);
      expect(result, TypeMatcher<List<Tag>>());
    });
  });

  group('ProjectDao', () {
    final parentProject = Project(projectName: 'parent project');
    final newProject = Project(
        projectName: 'test project', parentName: parentProject.projectName);

    //*insertTag
    test('Should insert a proejcet successfully', () async {
      //act
      await projectDao.insertProject(parentProject);
      //assert
      Project returnedProject = await projectDao
          .watchProjectWithProjectName(parentProject.projectName)
          .first;
      expect(returnedProject, parentProject);
    });

    //*getAllTags
    test('Should get all the projects in the data base successfully', () async {
      //arrang
      await projectDao.insertProject(parentProject);
      await projectDao.insertProject(newProject);
      //act
      final result = await projectDao.getAllProjects();
      //assert
      expect(result, [parentProject, newProject]);
      expect(result, TypeMatcher<List<Project>>());
    });
  });

  tearDown(() async {
    //close the database
    await db.close();
  });
}
