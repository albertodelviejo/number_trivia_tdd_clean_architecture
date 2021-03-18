import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NumberTrivia extends Equatable {
  final String text;
  final int number;

<<<<<<< HEAD
  NumberTrivia({
    @required this.text,
    @required this.number,
  });

  @override
=======
  const NumberTrivia({@required this.text, @required this.number});

>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e
  List<Object> get props => [text, number];
}
