<<<<<<< HEAD
import '../bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
=======
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_architecture_code_alberto/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key key,
  }) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
<<<<<<< HEAD
  final controller = TextEditingController();
  String inputStr;
=======
  String inputStr;
  final controller = TextEditingController();
>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
<<<<<<< HEAD
=======
          onChanged: (value) {
            inputStr = value;
          },
>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
<<<<<<< HEAD
          onChanged: (value) {
            inputStr = value;
          },
=======
>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
<<<<<<< HEAD
        SizedBox(height: 10),
=======
        SizedBox(
          height: 10,
        ),
>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text('Search'),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed: dispatchConcrete,
              ),
            ),
<<<<<<< HEAD
            SizedBox(width: 10),
=======
            SizedBox(
              width: 10,
            ),
>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e
            Expanded(
              child: RaisedButton(
                child: Text('Get random trivia'),
                onPressed: dispatchRandom,
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(inputStr));
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}
