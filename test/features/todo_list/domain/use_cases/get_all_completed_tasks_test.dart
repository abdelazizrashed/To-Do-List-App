import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/use_cases/use_case.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_task.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/get_all_completed_tasks.dart';

class MockTodoListRepository extends Mock implements TodoListRepository {}

void main() {
  MockTodoListRepository mockTodoListRepository;
  GetAllCompletedTasks useCase;

  setUp(() {
    mockTodoListRepository = MockTodoListRepository();
    useCase = GetAllCompletedTasks(mockTodoListRepository);
  });

  //set up values
  final task1 = TodoTask(taskName: 'task 1');
  final task2 = TodoTask(taskName: 'task 2', dueDate: DateTime(2020));
  final taskList = [task1, task2];

  test('should return a list of tasks using the repository', () async {
    //arrange
    when(mockTodoListRepository.getAllUnfinishedTasks())
        .thenAnswer((_) async => Right(taskList));
    //act
    final result =await useCase(NoParams());
    //assert
    verify(mockTodoListRepository.getAllUnfinishedTasks());
    verifyNoMoreInteractions(mockTodoListRepository);
    expect(result, Right(taskList));
  });
}
