<<<<<<< HEAD
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  @override
  List<Object> get props => [];
=======
part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  final List props = const <dynamic>[];
  const NumberTriviaEvent([props]);
>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

<<<<<<< HEAD
  GetTriviaForConcreteNumber(this.numberString);

  @override
  List<Object> get props => [numberString];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
=======
  GetTriviaForConcreteNumber(this.numberString) : super([numberString]);
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {
  GetTriviaForRandomNumber();
}
>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e
