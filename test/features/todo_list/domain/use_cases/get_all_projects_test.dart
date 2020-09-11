import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/use_cases/use_case.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_project.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';
import 'package:todo_list/features/todo_list/domain/use_cases/get_all_projects.dart';

class MockTodoListRepository extends Mock implements TodoListRepository {}

void main() {
  MockTodoListRepository mockTodoListRepository;
  GetAllProjects useCase;

  setUp(() {
    mockTodoListRepository = MockTodoListRepository();
    useCase = GetAllProjects(mockTodoListRepository);
  });

  //set up values
  final project = TodoProject(projectName: 'test project');
  final List<TodoProject> projectList= [project];

  test('should return a list of all the project when success', () async {
    //arrange
    when(mockTodoListRepository.getAllProjects())
        .thenAnswer((realInvocation) async => Right(projectList));
    //act
    final result = await useCase(NoParams());
    //assert
    expect(result, Right(projectList));
    verify(mockTodoListRepository.getAllProjects());
    verifyNoMoreInteractions(mockTodoListRepository);
  });
}
