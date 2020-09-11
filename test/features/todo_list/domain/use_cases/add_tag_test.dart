import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_tag.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/add_tag.dart';

class MockTodoListRepository extends Mock implements TodoListRepository {}

void main() {
  MockTodoListRepository mockTodoListRepository;
  AddTag useCase;

  setUp(() {
    mockTodoListRepository = MockTodoListRepository();
    useCase = AddTag(mockTodoListRepository);
  });

  //set up values
  final tag = TodoTag(tagName: 'tag', tagColor: 1);

  test('should add a tag by calling the addTag method', () async {
    //act
    await useCase(tag);
    //assert
    verify(mockTodoListRepository.addTag(tag));
    verifyNoMoreInteractions(mockTodoListRepository);
  });
}
