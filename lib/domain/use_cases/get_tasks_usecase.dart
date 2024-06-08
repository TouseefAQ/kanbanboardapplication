import 'package:dartz/dartz.dart' hide Task;
import 'package:kanbanboard/application/core/exception/app_exception.dart';
import 'package:kanbanboard/application/core/usecases/usecase.dart';
import 'package:kanbanboard/domain/repo_interfaces/i_board_repo.dart';

import '../../data/models/task.dart';

class GetTasksUseSase implements UseCase<List<Task>, String> {
  GetTasksUseSase(this.repository);

  final IBoardRepo repository;

  @override
  Future<Either<ServerException, List<Task>>> call(String projectId) async {
    return await repository.getTasks(projectId);
  }
}
