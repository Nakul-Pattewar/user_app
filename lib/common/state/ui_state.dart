class UiState<T> {
  const UiState();

  T? getData() {
    if (this is Success<T>) {
      return (this as Success<T>).data;
    }
    return null;
  }

  Exception? getError() {
    if (this is Error<T>) {
      return (this as Error<T>).error;
    }
    return null;
  }
}

class Default<T> extends UiState<T> {}

class Loading<T> extends UiState<T> {}

class Error<T> extends UiState<T> {
  final Exception error;

  Error(this.error);
}

class Success<T> extends UiState<T> {
  final T data;

  Success(this.data);
}
