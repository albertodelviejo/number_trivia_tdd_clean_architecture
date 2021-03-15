import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture_code_alberto/core/error/failures.dart';
import 'package:flutter_tdd_clean_architecture_code_alberto/core/usecases/usecase.dart';
import 'package:flutter_tdd_clean_architecture_code_alberto/core/util/input_converter.dart';
import 'package:flutter_tdd_clean_architecture_code_alberto/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_architecture_code_alberto/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_tdd_clean_architecture_code_alberto/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_tdd_clean_architecture_code_alberto/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
        concrete: mockGetConcreteNumberTrivia,
        random: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('initialState should be Empty', () {
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'Test trivia');

    void setUpMockInputConverterSuccess() {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(tNumberParsed));
    }

    test(
        'should call the InputConverter to validate and convert the string to an unsigned integer',
        () async {
      setUpMockInputConverterSuccess();

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    blocTest('should emit [Error] when the input is invalid',
        build: () {
          when(mockInputConverter.stringToUnsignedInteger(any))
              .thenReturn(Left(InvalidInputFailure()));
          return NumberTriviaBloc(
              concrete: mockGetConcreteNumberTrivia,
              random: mockGetRandomNumberTrivia,
              inputConverter: mockInputConverter);
        },
        act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
        expect: [
          Error(
            message: INVALID_INPUT_FAILURE_MESSAGE,
          )
        ]);

    test('should get data from the concrete use case', () async {
      setUpMockInputConverterSuccess();

      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockGetConcreteNumberTrivia(any));

      verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
    });

    blocTest(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        setUpMockInputConverterSuccess();

        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

        return NumberTriviaBloc(
            concrete: mockGetConcreteNumberTrivia,
            random: mockGetRandomNumberTrivia,
            inputConverter: mockInputConverter);
      },
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      expect: [Loading(), Loaded(trivia: tNumberTrivia)],
    );

    blocTest(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        setUpMockInputConverterSuccess();

        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        return NumberTriviaBloc(
            concrete: mockGetConcreteNumberTrivia,
            random: mockGetRandomNumberTrivia,
            inputConverter: mockInputConverter);
      },
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      expect: [Loading(), Error(message: SERVER_FAILURE_MESSAGE)],
    );

    blocTest(
        'should emit [Loading, Error] with proper message for the error when getting data fails',
        build: () {
          setUpMockInputConverterSuccess();

          when(mockGetConcreteNumberTrivia(any))
              .thenAnswer((_) async => Left(CacheFailure()));

          return NumberTriviaBloc(
              concrete: mockGetConcreteNumberTrivia,
              random: mockGetRandomNumberTrivia,
              inputConverter: mockInputConverter);
        },
        act: (build) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
        expect: [Loading(), Error(message: CACHE_FAILURE_MESSAGE)]);
  });

  group('GetTriviaForRandomNumber', () {
    final tNumberTrivia = NumberTrivia(number: 1, text: 'Test trivia');

    test('should get data from the random use case', () async {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      bloc.add(GetTriviaForRandomNumber());
      await untilCalled(mockGetRandomNumberTrivia(any));

      verifyNever(mockGetRandomNumberTrivia(NoParams()));
    });

    blocTest('should emit [Loading, Loaded] when data is gotten successfully',
        build: () {
          when(mockGetRandomNumberTrivia(any))
              .thenAnswer((_) async => Right(tNumberTrivia));
          return NumberTriviaBloc(
              concrete: mockGetConcreteNumberTrivia,
              random: mockGetRandomNumberTrivia,
              inputConverter: mockInputConverter);
        },
        act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
        expect: [Loading(), Loaded(trivia: tNumberTrivia)]);

    blocTest('should emit [Loading, Error] when getting data fails',
        build: () {
          when(mockGetRandomNumberTrivia(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          return NumberTriviaBloc(
              concrete: mockGetConcreteNumberTrivia,
              random: mockGetRandomNumberTrivia,
              inputConverter: mockInputConverter);
        },
        act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
        expect: [Loading(), Error(message: SERVER_FAILURE_MESSAGE)]);

    blocTest(
        'should emit [Loading, Error] with proper message for the error when getting data fails',
        build: () {
          when(mockGetRandomNumberTrivia(any))
              .thenAnswer((_) async => Left(CacheFailure()));
          return NumberTriviaBloc(
              concrete: mockGetConcreteNumberTrivia,
              random: mockGetRandomNumberTrivia,
              inputConverter: mockInputConverter);
        },
        act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
        expect: [Loading(), Error(message: CACHE_FAILURE_MESSAGE)]);
  });
}
