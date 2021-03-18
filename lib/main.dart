import 'package:flutter/material.dart';
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
<<<<<<< HEAD
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
=======
          primaryColor: Colors.green.shade800,
          accentColor: Colors.green.shade600),
>>>>>>> 50ca362eadb408b155ea9cf403107f2e7f94e42e
      home: NumberTriviaPage(),
    );
  }
}
