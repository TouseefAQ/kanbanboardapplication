import 'package:dartz/dartz.dart' hide Task;
import 'package:kanbanboard/application/core/exception/app_exception.dart';
import 'package:kanbanboard/application/core/usecases/usecase.dart';
import 'package:kanbanboard/domain/entities/update_task_entity.dart';
import 'package:kanbanboard/domain/repo_interfaces/i_board_repo.dart';

import '../../data/models/task.dart';

class CreateTaskUseCase implements UseCase<Task, UpdateTaskEntity> {
  CreateTaskUseCase(this.repository);

  final IBoardRepo repository;

  @override
  Future<Either<ServerException, Task>> call(UpdateTaskEntity params) async {
    return await repository.createTask(params);
  }
}
