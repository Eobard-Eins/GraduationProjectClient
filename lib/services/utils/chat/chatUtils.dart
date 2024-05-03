import 'package:client_application/components/display/snackbar.dart';
import 'package:client_application/services/connect/ChatNetService.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:get/get.dart';

class ChatUtils extends GetConnect{
  static save({
    required String sender,
    required String receiver,
    //required int status,
    required String msg,
    required DateTime time,
    //required Function() onFailed
    required Function(dynamic) onSuccess
  }){
    ChatNetService().save(sender,receiver,msg,time,Status.notRead).then((value){
      if(value.isError()){
        snackbar.error("聊天记录保存失败", value.message!, value.statusCode);
      }else{
        onSuccess(value.data);
      }
    });
  }

  static void read({
    required int id,
    //required Function() onFailed
  }) {

  }
}