import 'package:dartz/dartz.dart';

import '../../core/exception/app_exception.dart';

Future<Either<ServerException, T>> repoFutureErrorHandler<T>(
    {required Future<T> Function() callBack}) async {
  try {
    return Right(await callBack());
  } catch (error) {
    return Left(error as ServerException);
  }
}

Either<ServerException, T> repoErrorHandler<T>(
    {required T Function() callBack}) {
  try {
    return Right(callBack());
  } catch (error) {
    return Left(error as ServerException);
  }
}
