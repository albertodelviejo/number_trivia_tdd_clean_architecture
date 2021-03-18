import 'package:dartz/dartz.dart';
<<<<<<< HEAD

=======
>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e
import '../../../../core/error/failures.dart';
import '../entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
