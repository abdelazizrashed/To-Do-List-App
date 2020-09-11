import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/add_project.dart';

class MockTodoListRepository extends Mock implements TodoListRepository {}

void main() {
  MockTodoListRepository mockTodoListRepository;
  AddProject useCase;

  setUp(() {
    mockTodoListRepository = MockTodoListRepository();
    useCase = AddProject(mockTodoListRepository);
  });

  //set up values
  final project = TodoProject(projectName: 'test project');

  test('should add a project by calling the addProject method successfully', () async {
    //act
    await useCase(project);
    //assert
    verify(mockTodoListRepository.addProject(project));
    verifyNoMoreInteractions(mockTodoListRepository);
  });
}
