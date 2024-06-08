import 'package:kanbanboard/application/core/usecases/usecase.dart';
import 'package:kanbanboard/data/models/section.dart';
import 'package:kanbanboard/data/models/task.dart';
import 'package:kanbanboard/domain/entities/comment_entity.dart';
import 'package:kanbanboard/domain/entities/update_task_entity.dart';

abstract class IBoardApi {
  Future<Task> createTask(UpdateTaskEntity entity);
  Future<Task> updateTask(UpdateTaskEntity entity);
  Future<List<Task>> getTasks(String projectId);
  Future<List<Section>> getSection(String projectId);
  Future<NoParams> addComment(CommentEntity param);
}
