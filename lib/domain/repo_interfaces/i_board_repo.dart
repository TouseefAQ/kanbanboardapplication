import 'package:dartz/dartz.dart' hide Task;
import 'package:kanbanboard/application/core/exception/app_exception.dart';
import 'package:kanbanboard/application/core/usecases/usecase.dart';
import 'package:kanbanboard/data/models/section.dart';
import 'package:kanbanboard/data/models/task.dart';
import 'package:kanbanboard/domain/entities/comment_entity.dart';
import 'package:kanbanboard/domain/entities/update_task_entity.dart';

abstract class IBoardRepo {
  Future<Either<ServerException, Task>> updateTask(UpdateTaskEntity entity);
  Future<Either<ServerException, List<Task>>> getTasks(String projectId);
  Future<Either<ServerException, Task>> createTask(UpdateTaskEntity entity);
  Future<Either<ServerException, List<Section>>> getSections(String projectId);
  Future<Either<ServerException, NoParams>> addComment(CommentEntity params);

}
