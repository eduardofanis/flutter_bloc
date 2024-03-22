class SearchCepState {}

class IdleState implements SearchCepState {}

class LoadingState implements SearchCepState {}

class ErrorState implements SearchCepState {
  final String message;
  ErrorState(this.message);
}

class SuccessState implements SearchCepState {
  final Map<String, dynamic> result;
  SuccessState(this.result);
}
