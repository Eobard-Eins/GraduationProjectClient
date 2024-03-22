
import 'package:client_application/tool/res/status.dart';

class Result<T> {
  T? data;
  int? statusCode;
  
  Result.success({required T this.data}){
    this.statusCode=Status.success;
  }
  Result.error({required int this.statusCode}){
    this.data=null;
  }
  Result.successBut({required int this.statusCode, required T this.data});
}

class NetError<T>{
  final int status;
  final String message;
  final T? data;

  NetError({required this.status, required this.message, this.data});
}