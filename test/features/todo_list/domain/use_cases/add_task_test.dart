import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_task.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/add_task.dart';

class MockTodoListRepository extends Mock implements TodoListRepository {}

void main() {
  MockTodoListRepository mockTodoListRepository;
  AddTask useCase;

  setUp(() {
    mockTodoListRepository = MockTodoListRepository();
    useCase = AddTask(mockTodoListRepository);
  });

  //set up values
  final task1 = TodoTask(taskName: 'task 1');

  test('should add a task by calling the addTask method', () async {
    //act
    await useCase(task1);
    //assert
    verify(mockTodoListRepository.addTask(task1));
    verifyNoMoreInteractions(mockTodoListRepository);
  });
}
