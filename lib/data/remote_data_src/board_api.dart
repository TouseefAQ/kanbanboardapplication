import 'package:dio/dio.dart';
import 'package:kanbanboard/application/constants/app_constants.dart';
import 'package:kanbanboard/application/core/exception/network_exceptions.dart';
import 'package:kanbanboard/application/core/usecases/usecase.dart';
import 'package:kanbanboard/application/network/client/iApService.dart';
import 'package:kanbanboard/data/models/section.dart';
import 'package:kanbanboard/data/models/task.dart';
import 'package:kanbanboard/domain/entities/comment_entity.dart';
import 'package:kanbanboard/domain/entities/update_task_entity.dart';

import 'i_board_api.dart';

class BoardApi implements IBoardApi {
  BoardApi(IApiService api) : dio = api.get();
  Dio dio;

  @override
  Future<Task> createTask(UpdateTaskEntity entity) async {
    try {
      final response =
          await dio.post(AppConstants.taskApi, data: entity.toMap());
      return Task.fromJson(response.data);
    } catch (e) {
      throw e.errorToServerException();
    }
  }

  @override
  Future<List<Task>> getTasks(String projectId) async {
    try {
      final response = await dio.get(AppConstants.taskApi);
      return response.data.map<Task>((task) => Task.fromJson(task)).toList();
    } catch (e) {
      throw e.errorToServerException();
    }
  }

  @override
  Future<Task> updateTask(UpdateTaskEntity entity) async {
    try {
      final response = await dio.post(
          "${AppConstants.taskApi}/${entity.taskId}",
          data: entity.toMap());
      return Task.fromJson(response.data);
    } catch (e) {
      throw e.errorToServerException();
    }
  }

  @override
  Future<List<Section>> getSection(String projectId) async {
    try {
      final response =
          await dio.get("${AppConstants.sectionApi}?projectId=$projectId");
      return response.data
          .map<Section>((task) => Section.fromJson(task))
          .toList();
    } catch (e) {
      throw e.errorToServerException();
    }
  }

  @override
  Future<NoParams> addComment(CommentEntity param) async {
    try {
      await dio.post(AppConstants.commentApi, data: param.toMap());
      return NoParams();
    } catch (e) {
      throw e.errorToServerException();
    }
  }
}
