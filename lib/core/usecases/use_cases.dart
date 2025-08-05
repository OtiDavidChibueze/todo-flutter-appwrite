import 'package:fpdart/fpdart.dart';
import 'package:todo_flutter_appwrite/core/error/failure.dart';

abstract class UseCases<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}
