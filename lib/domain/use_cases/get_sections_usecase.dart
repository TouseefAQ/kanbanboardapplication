import 'package:dartz/dartz.dart' hide Task;
import 'package:kanbanboard/application/core/exception/app_exception.dart';
import 'package:kanbanboard/application/core/usecases/usecase.dart';
import 'package:kanbanboard/data/models/section.dart';
import 'package:kanbanboard/domain/repo_interfaces/i_board_repo.dart';

class GetSectionsUseCase implements UseCase<List<Section>, String> {
  GetSectionsUseCase(this.repository);

  final IBoardRepo repository;

  @override
  Future<Either<ServerException, List<Section>>> call(String projectId) async {
    return await repository.getSections(projectId);
  }
}
