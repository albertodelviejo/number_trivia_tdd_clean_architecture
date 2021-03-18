import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
<<<<<<< HEAD

=======
>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e
import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

<<<<<<< HEAD
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
=======
class NoParams {}
>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e
