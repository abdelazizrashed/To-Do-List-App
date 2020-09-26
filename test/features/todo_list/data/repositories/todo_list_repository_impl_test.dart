import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:todo_list/core/error/exceptions.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/features/todo_list/data/data_sources/moor_database.dart'
    as moor;
import 'package:todo_list/features/todo_list/data/repositories/todo_list_repository_impl.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_tag.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_task.dart';

class MockTaskDao extends Mock implements moor.TaskDao {}

class MockTagDao extends Mock implements moor.TagDao {}

class MockProjectDao extends Mock implements moor.ProjectDao {}

void main() {
  TodoListRepositoryImpl repository;
  moor.AppDatabase db;
  MockTaskDao taskDao;
  MockTagDao tagDao;
  MockProjectDao projectDao;

  setUp(() {
    db = moor.AppDatabase(executor: VmDatabase.memory());
    taskDao = MockTaskDao();
    tagDao = MockTagDao();
    projectDao = MockProjectDao();
    repository = TodoListRepositoryImpl(
      db: db,
      taskDao: taskDao,
      tagDao: tagDao,
      projectDao: projectDao,
    );
  });

  //! Convertions
  group('This is a test for the convertion functions ', () {
    //* Test variables
    final moor.Tag tag = moor.Tag(tagName: 'test tag', color: 4);
    final moor.Project parentProject =
        moor.Project(projectName: 'parent project');
    final moor.Project project = moor.Project(
        projectName: 'test project', parentName: parentProject.projectName);
    final moor.Task task = moor.Task(
      id: 1,
      taskName: 'test task',
      completed: false,
      tagName: tag.tagName,
      projectName: parentProject.projectName,
    );
    final TodoTag todoTag = TodoTag(tagName: tag.tagName, tagColor: tag.color);
    final TodoProject parentTodoProject =
        TodoProject(projectName: parentProject.projectName);
    final TodoProject todoProject = TodoProject(
        projectName: project.projectName, parentProject: parentTodoProject);
    final TodoTask todoTask = TodoTask(
      id: task.id,
      completed: task.completed,
      taskName: task.taskName,
      tag: todoTag,
      project: parentTodoProject,
    );

    //* convertTag2TodoTag
    test('Should return a tag object when called', () async {
      //act
      final result = repository.convertTag2TodoTag(tag);
      //assert
      expect(result, todoTag);
    });

    test(
        'Should return a todoProject object when convertProject2TodoProject is called',
        () async {
      //arrang
      when(projectDao.getProjectByName(parentProject.projectName))
          .thenAnswer((_) async => parentProject);
      when(projectDao.getProjectByName(project.projectName))
          .thenAnswer((_) async => project);
      //act
      final result = await repository.convertProject2TodoProject(project);
      //assert
      expect(result, todoProject);
    });

    test(
        'Should return a TodoTask entity whe convertTask2TodoProject is called',
        () async {
      //arrang
      when(tagDao.getTagByName(tag.tagName)).thenAnswer((_) async => tag);
      when(projectDao.getProjectByName(parentProject.projectName))
          .thenAnswer((_) async => parentProject);
      //act
      final result = await repository.convertTask2TodoTask(task);
      //assert
      expect(result, todoTask);
    });
  });

  //! getAllUnfinishedTasks method tests
  group('getAllUnfinishedTasks', () {
    // ignore: missing_required_param
    final moor.Task task = moor.Task(taskName: 'test task', completed: false);

    test('Should return a list of the unfinished tasks', () async {
      //arrang
      when(taskDao.getAllUnfinishedTasks())
          .thenAnswer((realInvocation) async => [task]);
      final finalResult = await repository.convertTask2TodoTask(task);
      //act
      final result = await repository.getAllUnfinishedTasks();
      //assert
      result.fold((l) => null, (value) {
        expect(value[0], finalResult);
      });
      verify(taskDao.getAllUnfinishedTasks());
      verifyNoMoreInteractions(taskDao);
    });
    //shoul return a failure when there is an error while fetching the data
    test(
        'Should return a Database failure when a local data exception is thrown',
        () async {
      //arrang
      when(taskDao.getAllUnfinishedTasks()).thenThrow(LocalDataException);
      //act
      final result = await repository.getAllUnfinishedTasks();
      //assert
      result.fold((failure) => expect(failure, TypeMatcher<LocalDataFailure>()),
          (value) => null);
    });
  });

  //! getAllCompletedTasks method tests
  group('getAllCompletedTasks method tests', () {
    // ignore: missing_required_param
    final moor.Task task = moor.Task(taskName: 'test task', completed: true);

    test('Should return a list of the completed tasks', () async {
      //arrang
      when(taskDao.getAllCompletedTasks())
          .thenAnswer((realInvocation) async => [task]);
      final finalResult = await repository.convertTask2TodoTask(task);
      //act
      final result = await repository.getAllCompletedTasks();
      //assert
      result.fold((l) => null, (value) {
        expect(value[0], finalResult);
      });
      verify(taskDao.getAllCompletedTasks());
      verifyNoMoreInteractions(taskDao);
    });
    //shoul return a failure when there is an error while fetching the data
    test(
        'Should return a Database failure when a local data exception is thrown',
        () async {
      //arrang
      when(taskDao.getAllCompletedTasks()).thenThrow(LocalDataException);
      //act
      final result = await repository.getAllCompletedTasks();
      //assert
      result.fold((failure) => expect(failure, TypeMatcher<LocalDataFailure>()),
          (value) => null);
    });
  });
  //! getProjectsUnfinishedTasks method tests
  group('getProjectsUnfinishedTasks method tests', () {
    final project = moor.Project(projectName: 'test project');
    // ignore: missing_required_param
    final moor.Task task = moor.Task(
        taskName: 'test task',
        completed: false,
        projectName: project.projectName);

    test('Should return a list of the unfinished tasks of a specofic project ',
        () async {
      //arrang
      when(taskDao.getProjectsUnfinishedTasks(any))
          .thenAnswer((_) async => [task]);
      final todoProject = await repository.convertProject2TodoProject(project);
      final todoTask = await repository.convertTask2TodoTask(task);
      //act
      final result = await repository.getProjectsUnfinishedTasks(todoProject);
      //assert
      result.fold((l) => null, (value) {
        expect(value[0], todoTask);
      });
      verify(taskDao.getProjectsUnfinishedTasks(todoProject));
      verifyNoMoreInteractions(taskDao);
    });
    //shoul return a failure when there is an error while fetching the data
    test(
        'Should return a LocalDatafailure when a local data exception is thrown',
        () async {
      //arrang
      when(taskDao.getProjectsUnfinishedTasks(any))
          .thenThrow(LocalDataException);
      final todoProject = await repository.convertProject2TodoProject(project);

      //act
      final result = await repository.getProjectsUnfinishedTasks(todoProject);
      //assert
      result.fold((failure) => expect(failure, TypeMatcher<LocalDataFailure>()),
          (value) => null);
    });
  });
  //! getProjectsCompletedTasks method test
  group('getProjectsCompletedTasks method test', () {
    final project = moor.Project(projectName: 'test project');
    // ignore: missing_required_param
    final moor.Task task = moor.Task(
        taskName: 'test task',
        completed: true,
        projectName: project.projectName);

    test('Should return a list of the completed tasks of a specofic project ',
        () async {
      //arrang
      when(taskDao.getProjectsCompletedTasks(any))
          .thenAnswer((_) async => [task]);
      final todoProject = await repository.convertProject2TodoProject(project);
      final todoTask = await repository.convertTask2TodoTask(task);
      //act
      final result = await repository.getProjectsCompletedTasks(todoProject);
      //assert
      result.fold((l) => null, (value) {
        expect(value[0], todoTask);
      });
      verify(taskDao.getProjectsCompletedTasks(todoProject));
      verifyNoMoreInteractions(taskDao);
    });
    //shoul return a failure when there is an error while fetching the data
    test(
        'Should return a Database failure when a local data exception is thrown',
        () async {
      //arrang
      when(taskDao.getProjectsCompletedTasks(any))
          .thenThrow(LocalDataException);
      final todoProject = await repository.convertProject2TodoProject(project);

      //act
      final result = await repository.getProjectsCompletedTasks(todoProject);
      //assert
      result.fold((failure) => expect(failure, TypeMatcher<LocalDataFailure>()),
          (value) => null);
    });
  });

  //! getTodaysTasks
  group('getTodaysTasks method test', () {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    final moor.Task task =
        // ignore: missing_required_param
        moor.Task(taskName: 'test task', completed: false, dueDate: today);

    test('Should get a list of the tasks that are due today ', () async {
      //arrang
      when(taskDao.getTodaysTasks()).thenAnswer((_) async => [task]);
      final todoTask = await repository.convertTask2TodoTask(task);
      //act
      final result = await repository.getTodaysTasks();
      //assert
      result.fold((l) => null, (value) {
        expect(value[0], todoTask);
      });
      verify(taskDao.getTodaysTasks());
      verifyNoMoreInteractions(taskDao);
    });
    //shoul return a failure when there is an error while fetching the data
    test(
        'Should return a Database failure when a local data exception is thrown',
        () async {
      //arrang
      when(taskDao.getTodaysTasks()).thenThrow(LocalDataException);
      //act
      final result = await repository.getTodaysTasks();
      //assert
      result.fold((failure) => expect(failure, TypeMatcher<LocalDataFailure>()),
          (value) => null);
    });
  });

  //! addTask
  group('addTask method test', () {
    // ignore: missing_required_param
    final moor.Task task = moor.Task(taskName: 'test task', completed: false);

    test('Should call the insertTask method when a task is added ', () async {
      //arrange
      final todoTask = await repository.convertTask2TodoTask(task);
      //act
      await repository.addTask(todoTask);
      //assert
      verify(taskDao.insertTask(task));
      verifyNoMoreInteractions(taskDao);
    });
    //shoul return a failure when there is an error while fetching the data
    test(
        'Should return a Database failure when a local data exception is thrown',
        () async {
      //arrang
      when(taskDao.insertTask(any)).thenThrow(LocalDataException);
      final todoTask = await repository.convertTask2TodoTask(task);

      //act
      final result = await repository.addTask(todoTask);
      //assert
      result.fold((failure) => expect(failure, TypeMatcher<LocalDataFailure>()),
          (value) => null);
    });
  });

  //! deleteTask
  group('deleteTask method test', () {
    // ignore: missing_required_param
    final moor.Task task = moor.Task(taskName: 'test task', completed: false);

    test('Should call the delete task method when a task is deleted ',
        () async {
      //arrange
      final todoTask = await repository.convertTask2TodoTask(task);
      //act
      await repository.deleteTask(todoTask);
      //assert
      verify(taskDao.deleteTask(task));
      verifyNoMoreInteractions(taskDao);
    });
    //shoul return a failure when there is an error while fetching the data
    test(
        'Should return a Database failure when a local data exception is thrown',
        () async {
      //arrang
      when(taskDao.deleteTask(any)).thenThrow(LocalDataException);
      final todoTask = await repository.convertTask2TodoTask(task);
      //act
      final result = await repository.deleteTask(todoTask);
      //assert
      result.fold((failure) => expect(failure, TypeMatcher<LocalDataFailure>()),
          (value) => null);
    });
  });

  //! modifyTask
  group('modifyTask method test', () {
    // ignore: missing_required_param
    final moor.Task task = moor.Task(
      taskName: 'test task',
      completed: false,
    );

    test('Should call the updateTask method when a task is modified ',
        () async {
      //arrange
      final todoTask = await repository.convertTask2TodoTask(task);
      //act
      await repository.modifyTask(todoTask);
      //assert
      verify(taskDao.updateTask(task));
      verifyNoMoreInteractions(taskDao);
    });
    //shoul return a failure when there is an error while fetching the data
    test(
        'Should return a Database failure when a local data exception is thrown',
        () async {
      //arrang
      when(taskDao.updateTask(any)).thenThrow(LocalDataException);
      final todoTask = await repository.convertTask2TodoTask(task);
      //act
      final result = await repository.modifyTask(todoTask);
      //assert
      result.fold((failure) => expect(failure, TypeMatcher<LocalDataFailure>()),
          (value) => null);
    });
  });

  //! getAllTags
  group('getAllTags method test', () {
    final moor.Tag tag = moor.Tag(tagName: 'test tag', color: 2);
    test('Should return a list of all the tag ', () async {
      //arrang
      when(tagDao.getAllTags()).thenAnswer((_) async => [tag]);
      final todoTag = repository.convertTag2TodoTag(tag);
      //act
      final result = await repository.getAllTags();
      //assert
      result.fold((l) => null, (value) {
        print(value.length);
        expect(value[0], todoTag);
      });
      verify(tagDao.getAllTags());
      verifyNoMoreInteractions(tagDao);
    });

    test(
        'Should return a LocalDataFailure when a LocalDataException is thrown ',
        () async {
      //arrang
      when(tagDao.getAllTags()).thenThrow(LocalDataException);
      //act
      final result = await repository.getAllTags();
      //assert
      result.fold((failure) => expect(failure, TypeMatcher<LocalDataFailure>()),
          (r) => null);
    });
  });
  //! addTag
  group('addTag method test', () {
    final moor.Tag tag = moor.Tag(tagName: 'test tag', color: 2);
    test('Should return a list of all the tag ', () async {
      //arrang
      final todoTag = repository.convertTag2TodoTag(tag);
      //act
      await repository.addTag(todoTag);
      //assert
      verify(tagDao.insertTag(tag));
      verifyNoMoreInteractions(tagDao);
    });

    test(
        'Should return a LocalDataFailure when a LocalDataException is thrown ',
        () async {
      //arrang
      when(tagDao.insertTag(any)).thenThrow(LocalDataException);
      final todoTag = repository.convertTag2TodoTag(tag);
      //act
      final result = await repository.addTag(todoTag);
      //assert
      result.fold((failure) => expect(failure, TypeMatcher<LocalDataFailure>()),
          (r) => null);
    });
  });
  //! modifyTag
  group('modifyTag method test', () {
    final moor.Tag tag = moor.Tag(tagName: 'test tag', color: 2);
    test('Should call the updateTag method when a tag is updated ', () async {
      //arrang
      final todoTag = repository.convertTag2TodoTag(tag);
      //act
      await repository.modifyTag(todoTag);
      //assert
      verify(tagDao.updateTag(tag));
      verifyNoMoreInteractions(tagDao);
    });

    test(
        'Should return a LocalDataFailure when a LocalDataException is thrown ',
        () async {
      //arrang
      when(tagDao.updateTag(any)).thenThrow(LocalDataException);
      final todoTag = repository.convertTag2TodoTag(tag);
      //act
      final result = await repository.modifyTag(todoTag);
      //assert
      result.fold((failure) => expect(failure, TypeMatcher<LocalDataFailure>()),
          (r) => null);
    });
  });

  //! deleteTag
  group('deleteTag method test', () {
    final moor.Tag tag = moor.Tag(tagName: 'test tag', color: 2);
    test('Should call the deleteTag method when a tag is deleted', () async {
      //arrang
      final todoTag = repository.convertTag2TodoTag(tag);
      //act
      await repository.deleteTag(todoTag);
      //assert
      verify(tagDao.deleteTag(tag));
      verifyNoMoreInteractions(tagDao);
    });

    test(
        'Should return a LocalDataFailure when a LocalDataException is thrown ',
        () async {
      //arrang
      when(tagDao.deleteTag(any)).thenThrow(LocalDataException);
      final todoTag = repository.convertTag2TodoTag(tag);
      //act
      final result = await repository.deleteTag(todoTag);
      //assert
      result.fold((failure) => expect(failure, TypeMatcher<LocalDataFailure>()),
          (r) => null);
    });
  });

  //! getAllProjects
  group('getAllProjects method test', () {
    final moor.Project project = moor.Project(projectName: 'testProject');
    test(
        'Should get a list of the all the project when getAllProjects is called',
        () async {
      //arrang
      when(projectDao.getAllProjects())
          .thenAnswer((realInvocation) async => [project]);
      final todoProject = await repository.convertProject2TodoProject(project);
      //act
      final result = await repository.getAllProjects();
      //assert
      result.fold((l) => null, (value) => expect(value[0], todoProject));
      verify(projectDao.getAllProjects());
      verifyNoMoreInteractions(projectDao);
    });

    test(
        'Should return a LocalDataFailure when a LocalDataException is thrown ',
        () async {
      //arrang
      when(projectDao.getAllProjects()).thenThrow(LocalDataException);
      //act
      final result = await repository.getAllProjects();
      //assert
      result.fold((failure) => expect(failure, TypeMatcher<LocalDataFailure>()),
          (r) => null);
    });
  });

  //! addProject
  group('addProject method test', () {
    final moor.Project project = moor.Project(projectName: 'testProject');

    test('Should call the addProject method when a project is added', () async {
      //arrang
      final todoProject = await repository.convertProject2TodoProject(project);
      //act
      await repository.addProject(todoProject);
      //assert
      verify(projectDao.insertProject(project));
      verifyNoMoreInteractions(projectDao);
    });

    test(
        'Should return a LocalDataFailure when a LocalDataException is thrown ',
        () async {
      //arrang
      when(projectDao.insertProject(any)).thenThrow(LocalDataException);
      final todoProject = await repository.convertProject2TodoProject(project);
      //act
      final result = await repository.addProject(todoProject);
      //assert
      result.fold((failure) => expect(failure, TypeMatcher<LocalDataFailure>()),
          (r) => null);
    });
  });

  //! deleteProject
  group('deleteProject method test', () {
    final moor.Project project = moor.Project(projectName: 'testProject');

    test('Should call the deleteProject method when a project is deleted', () async {
      //arrang
      final todoProject = await repository.convertProject2TodoProject(project);
      //act
      await repository.deleteProject(todoProject);
      //assert
      verify(projectDao.deleteProject(project));
      verifyNoMoreInteractions(projectDao);
    });

    test(
        'Should return a LocalDataFailure when a LocalDataException is thrown ',
        () async {
      //arrang
      when(projectDao.deleteProject(any)).thenThrow(LocalDataException);
      final todoProject = await repository.convertProject2TodoProject(project);
      //act
      final result = await repository.deleteProject(todoProject);
      //assert
      result.fold((failure) => expect(failure, TypeMatcher<LocalDataFailure>()),
          (r) => null);
    });
  });

}
