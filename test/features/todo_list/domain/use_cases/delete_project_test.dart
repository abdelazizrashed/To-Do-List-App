import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/delete_project.dart';

class MockTodoListRepository extends Mock implements TodoListRepository {}

void main() {
  MockTodoListRepository mockTodoListRepository;
  DeleteProject useCase;

  setUp(() {
    mockTodoListRepository = MockTodoListRepository();
    useCase = DeleteProject(mockTodoListRepository);
  });

  //set up values
  final project = TodoProject(projectName: 'test project');

  test('should delete a project by calling the deleteProject method', () async {
    //act
    await useCase(project);
    //assert
    verify(mockTodoListRepository.deleteProject(project));
    verifyNoMoreInteractions(mockTodoListRepository);
  });
}
