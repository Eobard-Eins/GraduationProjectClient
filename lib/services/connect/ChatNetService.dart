import 'package:client_application/res/staticValue.dart';
import 'package:client_application/tool/res/result.dart';
import 'package:get/get.dart';

class ChatNetService extends GetConnect{
  ChatNetService._internal();
  factory ChatNetService() => _instance;
  static final ChatNetService _instance = ChatNetService._internal();
  static ChatNetService getInstance() => _instance;

  final String _baseUrl=staticValue.URL;

  Future<Result> save(
    String sender,
    String receiver,
    String msg,
    DateTime time,
    int status
  ) async{
    return await network(() => post("$_baseUrl/chat/saveChat",'{"sender":"$sender","receiver":"$receiver","msg":"$msg","time":${time.millisecondsSinceEpoch},"status":$status}'));
  }
  Future<Result> read({required String him, required String me}) async{
    return await network(() => put("$_baseUrl/chat/setRead",{},query: {"u1":him,"u2":me}));
  }
  Future<Result> history({required String him, required String me, required int page, int size=10}) async{
    return await network(() => get("$_baseUrl/chat/getHistory",query: {"u1":him,"u2":me,"page":page.toString(),"size":size.toString()}));
  }
  Future<Result> getConvs({required String u,required int page,required int size}) async{
    return await network(() => get("$_baseUrl/chat/getChatUser",query: {"u":u,"page":page.toString(),"size":size.toString()}));
  }

  Future<Result> network(Future<Response> Function() func)async{

    final Result res=await func().then((value){
      if(!value.isOk){
        printInfo(info:"网络异常，不能连接服务器");
        return Result.error(message: "网络出现错误，请检查网络设置:Net error");
      }else{
        //printInfo(info:"网络正常 ${value.body.toString()}");
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