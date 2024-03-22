import 'package:aula_flutter_bloc/app/home/search_cep_bloc.dart';
import 'package:aula_flutter_bloc/app/home/search_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();

  when(() => dio.get(any())).thenAnswer(
    (_) async => Response(
      statusCode: 200,
      data: {'cep': '81550530', 'localidade': 'Curitiba', 'uf': 'PR'},
      requestOptions: RequestOptions(),
    ),
  );
  blocTest<SearchCepBloc, SearchCepState>(
    'Deve retornar uma cidade quando passado o cep por parametro',
    build: () => SearchCepBloc(dio),
    act: (bloc) => bloc.add('81550530'),
    expect: () => [
      isA<LoadingState>(),
      isA<SuccessState>(),
    ],
  );
}
