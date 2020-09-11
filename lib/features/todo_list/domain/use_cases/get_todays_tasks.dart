import 'package:dartz/dartz.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/core/use_cases/use_case.dart';
import 'package:todo_list/features/todo_list/domain/entities/todo_task.dart';
import 'package:todo_list/features/todo_list/domain/repositories/todo_list_repository.dart';

class GetTodaysTasks implements UseCase<List<TodoTask>, NoParams>{
  final TodoListRepository todoListRepository;

  GetTodaysTasks(this.todoListRepository);

  @override
  Future<Either<Failure, List<TodoTask>>> call(NoParams params) {
    return todoListRepository.getAllUnfinishedTasks();
  }

}