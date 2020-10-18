import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/error/error_messages.dart';
import 'package:todo_list/core/error/failure.dart';
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
import 'package:todo_list/features/todo_list/presentation/bloc/todo_list_bloc.dart';

class MockAddTask extends Mock implements AddTask {}

class MockGetAllUnfinishedTasks extends Mock implements GetAllUnfinishedTasks {}

class MockGetAllCompletedTasks extends Mock implements GetAllCompletedTasks {}

class MockGetProjectsUnfinishedTasks extends Mock
    implements GetProjectsUnfinishedTasks {}

class MockGetProjectsCompletedTasks extends Mock
    implements GetProjectsCompletedTasks {}

class MockModifyTask extends Mock implements ModifyTask {}

class MockDeleteTask extends Mock implements DeleteTask {}

class MockAddTag extends Mock implements AddTag {}

class MockGetAllTags extends Mock implements GetAllTags {}

class MockModifyTag extends Mock implements ModifyTag {}

class MockDeleteTag extends Mock implements DeleteTag {}

class MockAddProject extends Mock implements AddProject {}

class MockGetAllProjects extends Mock implements GetAllProjects {}

class MockDeleteProject extends Mock implements DeleteProject {}

void main() {
  MockAddTask mockAddTask;
  MockGetAllCompletedTasks mockGetAllCompletedTasks;
  MockGetAllUnfinishedTasks mockGetAllUnfinishedTasks;
  MockGetProjectsCompletedTasks mockGetProjectsCompletedTasks;
  MockGetProjectsUnfinishedTasks mockGetProjectsUnfinishedTasks;
  MockModifyTask mockModifyTask;
  MockDeleteTask mockDeleteTask;
  MockAddTag mockAddTag;
  MockGetAllTags mockGetAllTags;
  MockModifyTag mockModifyTag;
  MockDeleteTag mockDeleteTag;
  MockAddProject mockAddProject;
  MockGetAllProjects mockGetAllProjects;
  MockDeleteProject mockDeleteProject;
  TodoListBloc bloc;

  setUp(() {
    mockAddProject = MockAddProject();
    mockAddTag = MockAddTag();
    mockAddTask = MockAddTask();
    mockGetAllCompletedTasks = MockGetAllCompletedTasks();
    mockGetAllUnfinishedTasks = MockGetAllUnfinishedTasks();
    mockGetProjectsCompletedTasks = MockGetProjectsCompletedTasks();
    mockGetProjectsUnfinishedTasks = MockGetProjectsUnfinishedTasks();
    mockModifyTask = MockModifyTask();
    mockDeleteTask = MockDeleteTask();
    mockGetAllTags = MockGetAllTags();
    mockModifyTag = MockModifyTag();
    mockDeleteTag = MockDeleteTag();
    mockGetAllProjects = MockGetAllProjects();
    mockDeleteProject = MockDeleteProject();
    bloc = TodoListBloc(
      addTask: mockAddTask,
      getAllCompletedTasks: mockGetAllCompletedTasks,
      getAllUnfinishedTasks: mockGetAllUnfinishedTasks,
      getProjectsCompletedTasks: mockGetProjectsCompletedTasks,
      getProjectsUnfinishedTasks: mockGetProjectsUnfinishedTasks,
      modifyTask: mockModifyTask,
      deleteTask: mockDeleteTask,
      addTag: mockAddTag,
      getAllTags: mockGetAllTags,
      modifyTag: mockModifyTag,
      deleteTag: mockDeleteTag,
      addProject: mockAddProject,
      getAllProjects: mockGetAllProjects,
      deleteProject: mockDeleteProject,
    );
  });

  test('should check that the initial state is Empty', () {
    expect(bloc.state, equals(Empty()));
  });

//Todo: now I will work as if getting the data when the there is a change will happen inside the UI but if that is not the case just change the bloc that every time a something change emit a state with the new changes
  group('events that do not emit states', () {
    final TodoTask task = TodoTask(taskName: 'test task');
    final TodoTag tag = TodoTag(tagName: 'test tag', tagColor: 4);
    final TodoProject project = TodoProject(projectName: 'test project');
    //*AddTaskEvent
    blocTest('should call the AddTask useCase when the AddTaskEvent is added',
        build: () {
          return bloc;
        },
        act: (bloc) => bloc.add(AddTaskEvent(task)),
        verify: (_) async {
          await untilCalled(mockAddTask(any));
          verify(mockAddTask(task));
        });

    //*ModifyTaskEvent
    blocTest(
        'should call the ModifyTask useCase when the ModifyTaskEvent is added ',
        build: () {
          return bloc;
        },
        act: (bloc) => bloc.add(ModifyTaskEvent(task)),
        verify: (_) async {
          await untilCalled(mockModifyTask(any));
          verify(mockModifyTask(task));
        });

    //*DeleteTaskEvent
    blocTest(
        'should call the DeleteTask usecase when the DeleteTaskEvent is added',
        build: () {
          return bloc;
        },
        act: (bloc) => bloc.add(DeleteTaskEvent(task)),
        verify: (_) async {
          await untilCalled(mockDeleteTask(any));
          verify(mockDeleteTask(task));
        });

    //*AddTagEvent
    blocTest('should call the AddTag usecase when the AddTagEvent is added',
        build: () {
          return bloc;
        },
        act: (bloc) => bloc.add(AddTagEvent(tag)),
        verify: (_) async {
          await untilCalled(mockAddTag(any));
          verify(mockAddTag(tag));
        });

    //*ModifyTagEvent
    blocTest(
        'should call the ModifyTag usecase when the ModifyTagEvent is added',
        build: () {
          return bloc;
        },
        act: (bloc) => bloc.add(ModifyTagEvent(tag)),
        verify: (_) async {
          await untilCalled(mockModifyTag(any));
          verify(mockModifyTag(tag));
        });

    //*DeleteTagEvent
    blocTest(
        'should call the DeleteTag usecase when the DeleteTagEvent is added',
        build: () {
          return bloc;
        },
        act: (bloc) => bloc.add(DeleteTagEvent(tag)),
        verify: (_) async {
          await untilCalled(mockDeleteTag(any));
          verify(mockDeleteTag(tag));
        });

    //*AddProjectEvent
    blocTest(
        'should call the AddProject usecase when the AddProjectEvent is added',
        build: () {
          return bloc;
        },
        act: (bloc) => bloc.add(AddProjectEvent(project)),
        verify: (_) async {
          await untilCalled(mockAddProject(any));
          verify(mockAddProject(project));
        });

    //*DeleteProjectEvent
    blocTest(
        'should call the DeleteProject usecase when the DeleteProjectEvent is added',
        build: () {
          return bloc;
        },
        act: (bloc) => bloc.add(DeleteProjectEvent(project)),
        verify: (_) async {
          await untilCalled(mockDeleteProject(any));
          verify(mockDeleteProject(project));
        });
  });

  group('GetAllUnfinishedTasksEvent', () {
    final TodoTask taskUnfinished =
        TodoTask(taskName: 'test task', completed: false);
    blocTest('should call the GetAllUnfinishedTasks usecase ',
        build: () {
          when(mockGetAllUnfinishedTasks(any))
              .thenAnswer((_) async => Right([taskUnfinished]));
          return bloc;
        },
        act: (bloc) => bloc.add(GetAllUnfinishedTasksEvent()),
        verify: (_) async {
          await untilCalled(mockGetAllUnfinishedTasks(NoParams()));
          verify(mockGetAllUnfinishedTasks(NoParams()));
        });

    blocTest(
        'should emit [Loading, AllUnfinishedTasks] when data is gotten successfully',
        build: () {
          when(mockGetAllUnfinishedTasks(any))
              .thenAnswer((_) async => Right([taskUnfinished]));
          return bloc;
        },
        act: (bloc) => bloc.add(GetAllUnfinishedTasksEvent()),
        expect: [
          Loading(),
          AllUnfinishedTasksState([taskUnfinished]),
        ]);

    blocTest('should emit [Loading, Error] when there is an error',
        build: () {
          when(mockGetAllUnfinishedTasks(any))
              .thenAnswer((_) async => Left(LocalDataFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(GetAllUnfinishedTasksEvent()),
        expect: [
          Loading(),
          Error(LOCAL_DATA_ERROR),
        ]);
  });

  group('GetAllCompletedTasksEvent', () {
    final TodoTask taskCompleted =
        TodoTask(taskName: 'test task', completed: true);

    blocTest('should call the GetAllCompletedTasks usecase ',
        build: () {
          when(mockGetAllCompletedTasks(any))
              .thenAnswer((_) async => Right([taskCompleted]));
          return bloc;
        },
        act: (bloc) => bloc.add(GetAllCompletedTasksEvent()),
        verify: (_) async {
          await untilCalled(mockGetAllCompletedTasks(NoParams()));
          verify(mockGetAllCompletedTasks(NoParams()));
        });

    blocTest(
        'should emit [Loading, AllCompletedTasks] when data is gotten successfully',
        build: () {
          when(mockGetAllCompletedTasks(any))
              .thenAnswer((_) async => Right([taskCompleted]));
          return bloc;
        },
        act: (bloc) => bloc.add(GetAllCompletedTasksEvent()),
        expect: [
          Loading(),
          AllCompletedTasksState([taskCompleted]),
        ]);

    blocTest('should emit [Loading, Error] when there is an error',
        build: () {
          when(mockGetAllCompletedTasks(any))
              .thenAnswer((_) async => Left(LocalDataFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(GetAllCompletedTasksEvent()),
        expect: [
          Loading(),
          Error(LOCAL_DATA_ERROR),
        ]);
  });

  group('GetProjectsUnfinishedTasks', () {
    final TodoProject project = TodoProject(projectName: 'test project');
    final TodoTask task =
        TodoTask(taskName: 'test task', completed: false, project: project);

    blocTest('should call the GetProjectsUnfinishedTasks usecase ',
        build: () {
          when(mockGetProjectsUnfinishedTasks(any))
              .thenAnswer((_) async => Right([task]));
          return bloc;
        },
        act: (bloc) => bloc.add(GetProjectsUnfinishedTasksEvent(project)),
        verify: (_) async {
          await untilCalled(mockGetProjectsUnfinishedTasks(any));
          verify(mockGetProjectsUnfinishedTasks(project));
        });

    blocTest(
        'should emit [Loading, AllProjectsUnfinishedTasks] when data is gotten successfully',
        build: () {
          when(mockGetProjectsUnfinishedTasks(any))
              .thenAnswer((_) async => Right([task]));
          return bloc;
        },
        act: (bloc) => bloc.add(GetProjectsUnfinishedTasksEvent(project)),
        expect: [
          Loading(),
          AllProjectsUnfinishedTasksState(project: project, tasksList: [task]),
        ]);

    blocTest('should emit [Loading, Error] when there is an error',
        build: () {
          when(mockGetProjectsUnfinishedTasks(any))
              .thenAnswer((_) async => Left(LocalDataFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(GetProjectsUnfinishedTasksEvent(project)),
        expect: [
          Loading(),
          Error(LOCAL_DATA_ERROR),
        ]);
  });

  group('GetProjectsCompletedTasks', () {
    final TodoProject project = TodoProject(projectName: 'test project');
    final TodoTask task =
        TodoTask(taskName: 'test task', completed: true, project: project);

    blocTest('should call the GetProjectsCompletedTasks usecase ',
        build: () {
          when(mockGetProjectsCompletedTasks(any))
              .thenAnswer((_) async => Right([task]));
          return bloc;
        },
        act: (bloc) => bloc.add(GetProjectsCompletedTasksEvent(project)),
        verify: (_) async {
          await untilCalled(mockGetProjectsCompletedTasks(any));
          verify(mockGetProjectsCompletedTasks(project));
        });

    blocTest(
        'should emit [Loading, AllProjectsCompletedTasks] when data is gotten successfully',
        build: () {
          when(mockGetProjectsCompletedTasks(any))
              .thenAnswer((_) async => Right([task]));
          return bloc;
        },
        act: (bloc) => bloc.add(GetProjectsCompletedTasksEvent(project)),
        expect: [
          Loading(),
          AllProjectsCompletedTasksState(project: project, tasksList: [task]),
        ]);

    blocTest('should emit [Loading, Error] when there is an error',
        build: () {
          when(mockGetProjectsCompletedTasks(any))
              .thenAnswer((_) async => Left(LocalDataFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(GetProjectsCompletedTasksEvent(project)),
        expect: [
          Loading(),
          Error(LOCAL_DATA_ERROR),
        ]);
  });

  group('GetAllTags', () {
    final TodoTag tag = TodoTag(tagColor: 3, tagName: 'test');

    blocTest('should call the GetAllTags usecase ',
        build: () {
          when(mockGetAllTags(any)).thenAnswer((_) async => Right([tag]));
          return bloc;
        },
        act: (bloc) => bloc.add(GetAllTagsEvent()),
        verify: (_) async {
          await untilCalled(mockGetAllTags(any));
          verify(mockGetAllTags(NoParams()));
        });

    blocTest(
        'should emit [Loading, AllTagsState] when data is gotten successfully',
        build: () {
          when(mockGetAllTags(any)).thenAnswer((_) async => Right([tag]));
          return bloc;
        },
        act: (bloc) => bloc.add(GetAllTagsEvent()),
        expect: [
          Loading(),
          AllTagsState([tag]),
        ]);

    blocTest('should emit [Loading, Error] when there is an error',
        build: () {
          when(mockGetAllTags(any))
              .thenAnswer((_) async => Left(LocalDataFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(GetAllTagsEvent()),
        expect: [
          Loading(),
          Error(LOCAL_DATA_ERROR),
        ]);
  });

  group('GetAllProjects', () {
    final project = TodoProject(projectName: 'test project');

    blocTest('should call the GetAllProjects usecase ',
        build: () {
          when(mockGetAllProjects(any))
              .thenAnswer((_) async => Right([project]));
          return bloc;
        },
        act: (bloc) => bloc.add(GetAllProjectsEvent()),
        verify: (_) async {
          await untilCalled(mockGetAllProjects(any));
          verify(mockGetAllProjects(NoParams()));
        });

    blocTest(
        'should emit [Loading, AllProjectsState] when data is gotten successfully',
        build: () {
          when(mockGetAllProjects(any))
              .thenAnswer((_) async => Right([project]));
          return bloc;
        },
        act: (bloc) => bloc.add(GetAllProjectsEvent()),
        expect: [
          Loading(),
          AllProjectsState([project]),
        ]);

    blocTest('should emit [Loading, Error] when there is an error',
        build: () {
          when(mockGetAllProjects(any))
              .thenAnswer((_) async => Left(LocalDataFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(GetAllProjectsEvent()),
        expect: [
          Loading(),
          Error(LOCAL_DATA_ERROR),
        ]);
  });
}
