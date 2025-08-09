import 'package:fpdart/fpdart.dart';
import '../error/failure.dart';

abstract class UseCases<T, Request> {
  Future<Either<Failure, T>> call(Request req);
}

class NoParams {}
