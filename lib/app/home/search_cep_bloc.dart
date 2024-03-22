import 'dart:async';

import 'package:aula_flutter_bloc/app/home/search_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

class SearchCepBloc extends Bloc<String, SearchCepState> {
  final Dio dio;

  SearchCepBloc(this.dio) : super(IdleState()) {
    on<String>((cep, emit) async {
      emit(LoadingState());
      try {
        final result = await _searchCep(cep);
        emit(SuccessState(result));
      } catch (e) {
        emit(ErrorState("Erro ao pesquisar"));
      }
    });
  }

  Future<Map<String, dynamic>> _searchCep(String cep) async {
    final response = await dio.get("https://viacep.com.br/ws/$cep/json/");
    return response.data;
  }

  void dispose() {
    close();
  }
}
