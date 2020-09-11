import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_task.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/delete_task.dart';

class MockTodoListRepository extends Mock implements TodoListRepository {}

void main() {
  MockTodoListRepository mockTodoListRepository;
  DeleteTask useCase;

  setUp(() {
    mockTodoListRepository = MockTodoListRepository();
    useCase = DeleteTask(mockTodoListRepository);
  });

  //set up values
  final task1 = TodoTask(taskName: 'task 1');

  test(
      'should delete the task by calling the deleteTask method of the repository',
      () async {
    //act
    await useCase(task1);
    //assert
    verify(mockTodoListRepository.deleteTask(task1));
    verifyNoMoreInteractions(mockTodoListRepository);
  });
}
