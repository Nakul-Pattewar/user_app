class UiState<T> {
  const UiState();
}

class Default<T> extends UiState<T> {}

class Loading<T> extends UiState<T> {}

class Error<T> extends UiState<T> {
  final Exception error;

  Error(this.error);

  Exception get getError => error;
}

class Success<T> extends UiState<T> {
  final T data;

  Success(this.data);

  T get getData => data;
}
