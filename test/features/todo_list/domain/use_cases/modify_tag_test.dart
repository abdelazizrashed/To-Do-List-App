import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_tag.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/modify_tag.dart';

class MockTodoListRepository extends Mock implements TodoListRepository {}

void main() {
  MockTodoListRepository mockTodoListRepository;
  ModifyTag useCase;

  setUp(() {
    mockTodoListRepository = MockTodoListRepository();
    useCase = ModifyTag(mockTodoListRepository);
  });

  //set up values
  final tag = TodoTag(tagName: 'test tag', tagColor: 1);
  test('should modify a tag by calling the modifyTag method', () async {
    //act
    await useCase(tag);
    //assert
    verify(mockTodoListRepository.modifyTag(tag));
    verifyNoMoreInteractions(mockTodoListRepository);
  });
}
