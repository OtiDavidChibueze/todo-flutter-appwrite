import 'package:fpdart/fpdart.dart';
import '../error/failure.dart';

abstract class UseCases<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}
