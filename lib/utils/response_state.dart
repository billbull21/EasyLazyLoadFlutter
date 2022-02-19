enum ResponseStates{
  LOADING,
  COMPLETE,
  ERROR
}

class ResponseState<ResultType> {
  ResponseStates? state;
  ResultType? data;
  String? exception;

  ResponseState({this.state, this.data, this.exception});

  static ResponseState<ResultType> loading<ResultType>() {
    return ResponseState(state: ResponseStates.LOADING);
  }

  static ResponseState<ResultType> complete<ResultType>(ResultType data) {
    return ResponseState(state: ResponseStates.COMPLETE, data: data);
  }

  static ResponseState<ResultType> error<ResultType>(String exception) {
    return ResponseState(state: ResponseStates.ERROR, exception: exception);
  }
}