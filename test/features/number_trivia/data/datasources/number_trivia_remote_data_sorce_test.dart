import 'dart:convert';

import 'package:clean_architecture_tdd_course/core/error/exceptions.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../core/fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''should perform a GET request on the URL with number 
        being the endpoint and with application/json header''', () async {
      setUpMockHttpClientSuccess200();

      dataSource.getConcreteNumberTrivia(tNumber);

      verify(mockHttpClient.get(
        Uri.https('numbersapi.com', '/$tNumber'),
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test('should return NumberTrivia when the response code is 200 (success)',
        () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      setUpMockHttpClientFailure404();

      final call = dataSource.getConcreteNumberTrivia;

      expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''should perform a GET request on the URL with number 
        being the endpoint and with application/json header''', () async {
      setUpMockHttpClientSuccess200();

      dataSource.getRandomNumberTrivia();

      verify(mockHttpClient.get(
        Uri.https('numbersapi.com', '/random'),
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test('should return NumberTrivia when the response code is 200 (success)',
        () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSource.getRandomNumberTrivia();

      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      setUpMockHttpClientFailure404();

      final call = dataSource.getRandomNumberTrivia;

      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
