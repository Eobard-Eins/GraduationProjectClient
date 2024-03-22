
import 'package:client_application/utils/res/result.dart';
import 'package:client_application/utils/res/status.dart';
import 'package:get/get.dart'as prefix;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart' ;

class dioService{
  dioService._internal();
  factory dioService() => _instance;
  static final dioService _instance = dioService._internal();
  static dioService getInstance() => _instance;

  
  final dio = Dio();

  Future<Result> uploadAvatar(XFile file, String account, String url) async {
    // 创建FormData对象以包含要上传的文件
    final formData = FormData.fromMap({
      // 根据后端API要求设置键名
      'file': await MultipartFile.fromFile(File(file.path).path),
      'pn':account
      // 如果有其他表单数据一同提交，可以这样添加
      // 'other_field': 'value',
    });

  
    // 发送POST请求到指定URL
    final response = await dio.post(url, data: formData).then((value){
      if(value.statusCode == 200 || value.statusCode == 201){
        printInfo(info:"网络正常,${value.data}");
        return Result.success(data: true);
      }else{
        printError(info:"网络异常，不能连接服务器");
        return Result.error(statusCode: Status.netError);
      }
    }).onError((error, stackTrace){
      printError(info:"网络异常且未知错误:${error.toString()}");
      return Result.error(statusCode: Status.netError);
    });
    return response;
  }

}