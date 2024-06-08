import 'package:dartz/dartz.dart';

abstract class UseCase<Type, T> {
  Future<Either<Exception, Type>> call(T prams);
}

abstract class UseCaseSync<Type, T> {
  Either<Exception, Type> call(T prams);
}

abstract class StreamUseCase<Type, T> {
  Stream<Either<Exception, Type>> call(T prams);
}

class NoParams {
  List<Object> get props => [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoParams && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
