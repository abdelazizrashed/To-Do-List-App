import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_task.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/get_projects_completed_tasks.dart';

class MockTodoListRepository extends Mock implements TodoListRepository {}

void main() {
  MockTodoListRepository mockTodoListRepository;
  GetProjectsCompletedTasks useCase;

  setUp(() {
    mockTodoListRepository = MockTodoListRepository();
    useCase = GetProjectsCompletedTasks(mockTodoListRepository);
  });

  //set up values
  final project = TodoProject(projectName: 'test project');
  final task1 = TodoTask(taskName: 'task 1', project: project, completed: true);

  test('should return a list of tasks of a specific project when successful',
      () async {
    //arrange
    when(mockTodoListRepository.getProjectsCompletedTasks(any))
        .thenAnswer((_) async => Right([task1]));
    //act
    final result = await useCase(project);
    //assert
    verify(mockTodoListRepository.getProjectsCompletedTasks(project));
    verifyNoMoreInteractions(mockTodoListRepository);
    result.fold(
      (l) => null,
      (value) => expect(value[0], equals(task1)),
    );
  });
}
