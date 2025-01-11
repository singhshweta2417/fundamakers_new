import 'package:fundamakers/helper/response/status.dart';

class ApiResponse<T> {
  Success success;
  T? data;
  String? message;

  ApiResponse.loading([this.message]) : success = Success.LOADING;
  ApiResponse.completed(this.data) : success = Success.COMPLETED;
  ApiResponse.error([this.message]) : success = Success.ERROR;

  @override
  String toString() {
    return "Status: $success, Message: $message, Data: $data";
  }
}


