import 'package:dartz/dartz.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/core/use_cases/use_case.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_tag.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';

class GetAllTags implements UseCase<List<TodoTag>, NoParams> {
  final TodoListRepository todoListRepository;

  GetAllTags(this.todoListRepository);

  @override
  Future<Either<Failure, List<TodoTag>>> call(NoParams params) {
    return todoListRepository.getAllTags();
  }
}
