import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/use_cases/use_case.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_tag.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/get_all_tags.dart';

class MockTodoListRepository extends Mock implements TodoListRepository {}

void main() {
  MockTodoListRepository mockTodoListRepository;
  GetAllTags useCase;

  setUp(() {
    mockTodoListRepository = MockTodoListRepository();
    useCase = GetAllTags(mockTodoListRepository);
  });

  //set up values
  final tag = TodoTag(tagName: 'test tag', tagColor: 1);
  final List<TodoTag> tagList = [tag];

  test('should return a list of all the tags when success', () async {
    //arrange
    when(mockTodoListRepository.getAllTags())
        .thenAnswer((_) async => Right(tagList));
    //act
    final result = await useCase(NoParams());
    //assert
    expect(result, Right(tagList));
    verify(mockTodoListRepository.getAllTags());
    verifyNoMoreInteractions(mockTodoListRepository);
  });
}
