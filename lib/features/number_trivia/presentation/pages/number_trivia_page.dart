<<<<<<< HEAD
import '../bloc/bloc.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
=======
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_architecture_code_alberto/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_tdd_clean_architecture_code_alberto/features/number_trivia/presentation/widgets/widgets.dart';
>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
<<<<<<< HEAD
=======
  const NumberTriviaPage({Key key}) : super(key: key);

>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
<<<<<<< HEAD
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
=======
      body: SingleChildScrollView(child: buildBody(context)),
>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
<<<<<<< HEAD
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
=======
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              //Top half of the screen
>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'Start searching!',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              // Bottom half
              TriviaControls()
            ],
          ),
        ),
      ),
    );
  }
}
