import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

<<<<<<< HEAD
// General failures
=======
//General failures

>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
