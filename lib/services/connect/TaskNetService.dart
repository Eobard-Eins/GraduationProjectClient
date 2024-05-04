
import 'dart:io';

import 'package:client_application/tool/res/result.dart';
import 'package:get/get.dart';
import 'package:client_application/res/staticValue.dart';
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
  }

  Future<Result> getTask(int id,String account) async{
    return await network(() => get("$_baseUrl/task/get",query:{"id":id.toString(),"user":account}));
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
      files.add(MultipartFile(File(i.path), filename: File(i.path).path));
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
  }

  Future<Result> like(int id,String account) async{
    return await network(() => put("$_baseUrl/task/like",'{"id":$id,"user":"$account"}'));
  }
  Future<Result> dislike(int id,String account) async{
    return await network(() => put("$_baseUrl/task/dislike",'{"id":$id,"user":"$account"}'));
  }

  Future<Result> getHistory(String account,int page,int size) async{
    return await network(() => get("$_baseUrl/task/history",query:{"user":account,"page":page.toString(),"size":size.toString()}));
  }
  Future<Result> requestTask(String account,int id) async{
    return await network(() => post("$_baseUrl/task/requestTask",'{"id":$id,"user":"$account"}'));
  }
  Future<Result> accessTask(int id,String account) async{
    return await network(() => put("$_baseUrl/task/access",'{"id":$id,"user":"$account"}'));
  }
  Future<Result> getTasksByPublicUser(String account,int status,int page,int size) async{
    return await network(() => get("$_baseUrl/task/getTasksByPublicUser",query:{"user":account,"status":status.toString(),"page":page.toString(),"size":size.toString()}));
  }
  Future<Result> getTasksByAccessUser(String account,int status,int page,int size) async{
    return await network(() => get("$_baseUrl/task/getTasksByAccessUser",query:{"user":account,"status":status.toString(),"page":page.toString(),"size":size.toString()}));
  }
  Future<Result> getAllRequestWithTask(int id) async{
    return await network(() => get("$_baseUrl/task/getRequestsWithTask",query:{"id":id.toString()}));
  }
  Future<Result> setStatus(int id,int status) async{
    return await network(() => put("$_baseUrl/task/setStatus",'{"id":$id,"status":$status}'));
  }

  Future<Result> network(Future<Response> Function() func)async{

    final Result res=await func().then((value){
      if(!value.isOk){
        printInfo(info:"网络异常，不能连接服务器");
        return Result.error(message: "网络出现错误，请检查网络设置:Net error");
      }else{
        printInfo(info:"网络正常 ${value.body.toString()}");
        bool isSuccess=value.body['isSuccess'];
        if(!isSuccess){
          printInfo(info:"网络正常，服务器返回错误：${value.body['message']}");
          return Result.error(message: value.body['message']);
        }      
        return Result.success(data: value.body['data'],statusCode: value.body['statusCode']);
      }
    }).onError((error, stackTrace){
      printInfo(info:"网络异常且未知错误  ${error.toString()}");
      return Result.error(message: "网络出现错误，请检查网络设置:Net error");
    }).timeout(const Duration(seconds: 15),onTimeout: (){
      return Result.error(message: "网络超时，请检查网络设置:Time out");
    });
    return res;
  }
}