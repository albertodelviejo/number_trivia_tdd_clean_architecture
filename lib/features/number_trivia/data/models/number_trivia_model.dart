import 'package:flutter/cupertino.dart';
import 'package:flutter_tdd_clean_architecture_code_alberto/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({@required String text, @required int number})
      : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
        text: json['text'], number: (json['number'] as num).round());
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'number': number};
  }
}
