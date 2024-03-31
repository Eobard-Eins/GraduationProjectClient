import 'package:client_application/models/User.dart';
import 'package:client_application/tool/res/result.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:get/get.dart';
import 'package:client_application/res/staticValue.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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

    final Result res=await get("$_baseUrl/task/getList",query:{"user":account,"num":k.toString(),"search":search,"distance":distance.toString(),"lat":lat.toString(),"lon":lon.toString()}).then((value){
      //value.printInfo();
      //printError(info:value.body.toString());
      if(!value.isOk){
        printInfo(info:"网络异常，不能连接服务器");
        return Result.error(statusCode: Status.netError);
      }else{
        printInfo(info:"网络正常,${value.body.toString()}");
        if(value.body['statusCode']!=Status.success){
          printInfo(info:"网络正常，服务器返回错误码：${value.body['statusCode']}");
          return Result.error(statusCode:value.body['statusCode']);
        }
        
        
        return Result.success(data: value.body['data']);
      }
    }).onError((error, stackTrace){
      printInfo(info:"网络异常且未知错误  ${error.toString()}");
      return Result.error(statusCode: Status.netError);
    }).timeout(const Duration(seconds: 3),onTimeout: (){
      return Result.error(statusCode: Status.netError);
    });
    return res;
  }

  // Future<Result> addNewTask(String account,String title,String content,double address, double lat, double lon,) async{

  //   final Result res=await get("$_baseUrl/task/getList",query:{"user":account,"num":k.toString(),"search":search,"distance":distance.toString(),"lat":lat.toString(),"lon":lon.toString()}).then((value){
  //     //value.printInfo();
  //     printError(info:value.body.toString());
  //     if(!value.isOk){
  //       printInfo(info:"网络异常，不能连接服务器");
  //       return Result.error(statusCode: Status.netError);
  //     }else{
  //       printInfo(info:"网络正常,${value.body.toString()}");
  //       if(value.body['statusCode']!=Status.success){
  //         printInfo(info:"网络正常，服务器返回错误码：${value.body['statusCode']}");
  //         return Result.error(statusCode:value.body['statusCode']);
  //       }
        
        
  //       return Result.success(data: T);
  //     }
  //   }).onError((error, stackTrace){
  //     printInfo(info:"网络异常且未知错误  ${error.toString()}");
  //     return Result.error(statusCode: Status.netError);
  //   }).timeout(const Duration(seconds: 3),onTimeout: (){
  //     return Result.error(statusCode: Status.netError);
  //   });
  //   return res;
  // }
}