
import 'package:client_application/tool/res/status.dart';

class Result<T> {
  T? data;
  int? statusCode;
  String? message;
  
  Result.success({required T this.data}){
    this.statusCode=Status.success;
  }
  Result.error({required String this.message}){
    this.data=null;
    this.statusCode=Status.error;
  }
  Result.successBut({required int this.statusCode, required T this.data});

  bool isSuccess(){
    return this.statusCode==Status.success;
  }
  bool isError(){
    return this.statusCode==Status.error;
  }
}

class NetError<T>{
  final int status;
  final String message;
  final T? data;

  NetError({required this.status, required this.message, this.data});
}