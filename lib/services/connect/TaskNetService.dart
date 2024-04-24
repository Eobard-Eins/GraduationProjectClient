import 'dart:ffi';
import 'dart:io';

import 'package:client_application/models/User.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/services/connect/Dio.dart';
import 'package:client_application/tool/res/result.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client_application/res/staticValue.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class TaskNetService extends GetConnect{
  TaskNetService._internal();
  factory TaskNetService() => _instance;
  static final TaskNetService _instance = TaskNetService._internal();
  static TaskNetService getInstance() => _instance;

  final String _baseUrl=staticValue.URL;

  @override
  void onInit(){
    super.onInit();
  }
  Future<Result> getTasks(String account,int k,String search,double distance, double lat, double lon) async{
    return await network(() => get("$_baseUrl/task/getList",query:{"user":account,"num":k.toString(),"search":search,"distance":distance.toString(),"lat":lat.toString(),"lon":lon.toString()}));
    // final Result res=await get("$_baseUrl/task/getList",query:{"user":account,"num":k.toString(),"search":search,"distance":distance.toString(),"lat":lat.toString(),"lon":lon.toString()}).then((value){
    //   //value.printInfo();
    //   //printError(info:value.body.toString());
    //   if(!value.isOk){
    //     printInfo(info:"网络异常，不能连接服务器");
    //     return Result.error(statusCode: Status.netError);
    //   }else{
    //     //printInfo(info:"网络正常,${value.body.toString()}");
    //     if(value.body['statusCode']!=Status.success){
    //       printInfo(info:"网络正常，服务器返回错误码：${value.body['statusCode']}");
    //       return Result.error(statusCode:value.body['statusCode']);
    //     }      
    //     return Result.success(data: value.body['data']);
    //   }
    // }).onError((error, stackTrace){
    //   printInfo(info:"网络异常且未知错误  ${error.toString()}");
    //   return Result.error(statusCode: Status.netError);
    // }).timeout(const Duration(seconds: 3),onTimeout: (){
    //   return Result.error(statusCode: Status.netError);
    // });
    // return res;
  }

  Future<Result> getTask(int id,String account) async{
    return await network(() => get("$_baseUrl/task/get",query:{"id":id.toString(),"user":account}));
    // final Result res=await get("$_baseUrl/task/get",query:{"id":id.toString(),"user":account}).then((value){
    //   //value.printInfo();
    //   //printError(info:value.body.toString());
    //   if(!value.isOk){
    //     printInfo(info:"网络异常，不能连接服务器");
    //     return Result.error(statusCode: Status.netError);
    //   }else{
    //     //printInfo(info:"网络正常,${value.body.toString()}");
    //     if(value.body['statusCode']!=Status.success){
    //       printInfo(info:"网络正常，服务器返回错误码：${value.body['statusCode']}");
    //       return Result.error(statusCode:value.body['statusCode']);
    //     }      
    //     return Result.success(data: value.body['data']);
    //   }
    // }).onError((error, stackTrace){
    //   printInfo(info:"网络异常且未知错误  ${error.toString()}");
    //   return Result.error(statusCode: Status.netError);
    // }).timeout(const Duration(seconds: 3),onTimeout: (){
    //   return Result.error(statusCode: Status.netError);
    // });
    // return res;
  }

  Future<Result> addNewTask(
    String account,
    String title,
    String content,
    List<String> tags,
    String addressName,
    String address, 
    double lat, 
    double lon,
    DateTime time, 
    List<XFile> imgs, 
    bool online,
    double point
  ) async{
    List<MultipartFile> files = [];
    for(var i in imgs){
      files.add(MultipartFile(i, filename: File(i.path).path));
    }
    final formData = FormData({
      "user":account,
      "title":title,
      "content":content,
      "tags":tags,
      "addressName":addressName,
      "address":address,
      "latitude":lat,
      "longitude":lon,
      "time":time.millisecondsSinceEpoch,
      "images":files,
      "onLine":online,
      "point":point.toStringAsFixed(2)
    });
    return await network(() => post("$_baseUrl/task/addTask",formData));
    // final Result res=await dioService().uploadTask("$_baseUrl/task/addTask",account,title,content,tags,addressName,address,lat,lon,time,imgs,online,point);
    // return res;
  }

  Future<Result> like(int id,String account) async{
    return await network(() => put("$_baseUrl/task/like",'{"id":$id,"user":"$account"}'));
    // final Result res=await put("$_baseUrl/task/like",{},query:{"id":id.toString(),"user":account}).then((value){
    //   if(!value.isOk){
    //     printInfo(info:"网络异常，不能连接服务器");
    //     return Result.error(statusCode: Status.netError);
    //   }else{
    //     if(value.body['statusCode']!=Status.success){
    //       printInfo(info:"网络正常，服务器返回错误码：${value.body['statusCode']}");
    //       return Result.error(statusCode:value.body['statusCode']);
    //     }      
    //     return Result.success(data: value.body['data']);
    //   }
    // }).onError((error, stackTrace){
    //   printInfo(info:"网络异常且未知错误  ${error.toString()}");
    //   return Result.error(statusCode: Status.netError);
    // }).timeout(const Duration(seconds: 3),onTimeout: (){
    //   return Result.error(statusCode: Status.netError);
    // });
    // return res;
  }
  Future<Result> dislike(int id,String account) async{
    return await network(() => put("$_baseUrl/task/dislike",'{"id":$id,"user":"$account"}'));
    // final Result res=await put("$_baseUrl/task/dislike",{},query:{"id":id.toString(),"user":account}).then((value){
    //   if(!value.isOk){
    //     printInfo(info:"网络异常，不能连接服务器");
    //     return Result.error(statusCode: Status.netError);
    //   }else{
    //     if(value.body['statusCode']!=Status.success){
    //       printInfo(info:"网络正常，服务器返回错误码：${value.body['statusCode']}");
    //       return Result.error(statusCode:value.body['statusCode']);
    //     }      
    //     return Result.success(data: value.body['data']);
    //   }
    // }).onError((error, stackTrace){
    //   printInfo(info:"网络异常且未知错误  ${error.toString()}");
    //   return Result.error(statusCode: Status.netError);
    // }).timeout(const Duration(seconds: 3),onTimeout: (){
    //   return Result.error(statusCode: Status.netError);
    // });
    // return res;
  }

  Future<Result> getHistory(String account,int num) async{
    return await network(() => get("$_baseUrl/task/history",query:{"user":account,"num":num.toString()}));
  }
  Future<Result> requestTask(String account,int id) async{
    return await network(() => post("$_baseUrl/task/requestTask",'{"id":$id,"user":"$account"}',uploadProgress: (percent) {
      printInfo(info:"上传进度：${percent.toString()}");
      Get.dialog(CircularProgressIndicator(
        value: percent,
        color: Coloors.main,
      ));
    },));
  }
  Future<Result> accessTask(int id,String account) async{
    return await network(() => put("$_baseUrl/task/access",'{"id":$id,"user":"$account"}'));
  }
  Future<Result> getTasksByPublicUser(String account,int status) async{
    return await network(() => get("$_baseUrl/task/getTasksByPublicUser",query:{"user":account,"status":status}));
  }
  Future<Result> getTasksByAccessUser(String account,int status) async{
    return await network(() => get("$_baseUrl/task/getTasksByAccessUser",query:{"user":account,"status":status}));
  }
  Future<Result> getAllRequestWithTask(int id) async{
    return await network(() => get("$_baseUrl/task/getRequestsWithTask",query:{"id":id}));
  }
  Future<Result> setStatus(int id,int status) async{
    return await network(() => put("$_baseUrl/task/setStatus",'{"id":$id,"user":$status}'));
  }

  Future<Result> network(Future<Response> Function() func)async{
    final Result res=await func().then((value){
      if(!value.isOk){
        printInfo(info:"网络异常，不能连接服务器");
        return Result.error(message: "网络出现错误，请坚持网络设置:Net error");
      }else{
        if(value.body['statusCode']!=Status.success){
          printInfo(info:"网络正常，服务器返回错误：${value.body['message']}");
          return Result.error(message: value.body['message']);
        }      
        return Result.success(data: value.body['data']);
      }
    }).onError((error, stackTrace){
      printInfo(info:"网络异常且未知错误  ${error.toString()}");
      return Result.error(message: "网络出现错误，请坚持网络设置:Net error");
    }).timeout(const Duration(seconds: 3),onTimeout: (){
      return Result.error(message: "网络超时，请坚持网络设置:Time out");
    });
    return res;
  }
}