import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_task.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/modify_task.dart';

class MockTodoListRepository extends Mock implements TodoListRepository {}

void main() {
  MockTodoListRepository mockTodoListRepository;
  ModifyTask useCase;

  setUp(() {
    mockTodoListRepository = MockTodoListRepository();
    useCase = ModifyTask(mockTodoListRepository);
  });

  //set up values
  final task = TodoTask(taskName: 'task 1');

  test('should modify a task by calling the modifyTask method', () async {
    //act
    await useCase(task);
    //assert
    verify(mockTodoListRepository.modifyTask(task));
    verifyNoMoreInteractions(mockTodoListRepository);
  });
}
