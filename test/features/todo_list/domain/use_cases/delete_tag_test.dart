import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_tag.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/delete_tag.dart';

class MockTodoListRepository extends Mock implements TodoListRepository {}

void main() {
  MockTodoListRepository mockTodoListRepository;
  DeleteTag useCase;

  setUp(() {
    mockTodoListRepository = MockTodoListRepository();
    useCase = DeleteTag(mockTodoListRepository);
  });

  //set up values
  final tag = TodoTag(tagName: 'test tag', tagColor: 1);

  test('should delete a tag by calling the deleteTag method', () async {
    //act
    await useCase(tag);
    //assert
    verify(mockTodoListRepository.deleteTag(tag));
    verifyNoMoreInteractions(mockTodoListRepository);
  });
}
