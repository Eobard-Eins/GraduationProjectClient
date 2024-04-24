
import 'package:client_application/tool/res/status.dart';

class Result<T> {
  T? data;
  int? statusCode;
  String? message;
  
  Result.error({required String this.message}){
    this.data=null;
    this.statusCode=Status.error;
  }
  Result.success({required int this.statusCode, required T this.data});

  bool isSuccess(){
    return this.statusCode==Status.success||this.statusCode==Status.successButUserNotExist;
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