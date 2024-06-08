import 'package:dartz/dartz.dart' hide Task;
import 'package:kanbanboard/application/core/exception/app_exception.dart';
import 'package:kanbanboard/application/core/usecases/usecase.dart';
import 'package:kanbanboard/data/models/section.dart';
import 'package:kanbanboard/data/remote_data_src/i_board_api.dart';
import 'package:kanbanboard/domain/entities/comment_entity.dart';
import 'package:kanbanboard/domain/entities/update_task_entity.dart';
import 'package:kanbanboard/domain/repo_interfaces/i_board_repo.dart';

import '../../application/network/network_helpers/repo_error_handler.dart';
import '../models/task.dart';

class BoardRepo implements IBoardRepo {
  final IBoardApi api;
  BoardRepo({required this.api});

  @override
  Future<Either<ServerException, Task>> createTask(UpdateTaskEntity entity) {
    return repoFutureErrorHandler(callBack: () {
      return api.createTask(entity);
    });
  }

  @override
  Future<Either<ServerException, List<Section>>> getSections(String projectId) {
    return repoFutureErrorHandler(callBack: () {
      return api.getSection(projectId);
    });
  }

  @override
  Future<Either<ServerException, List<Task>>> getTasks(String projectId) {
    return repoFutureErrorHandler(callBack: () {
      return api.getTasks(projectId);
    });
  }

  @override
  Future<Either<ServerException, Task>> updateTask(UpdateTaskEntity entity) {
    return repoFutureErrorHandler(callBack: () {
      return api.updateTask(entity);
    });
  }

  @override
  Future<Either<ServerException, NoParams>> addComment(CommentEntity params) {
    return repoFutureErrorHandler(callBack: () {
      return api.addComment(params);
    });
  }
}
