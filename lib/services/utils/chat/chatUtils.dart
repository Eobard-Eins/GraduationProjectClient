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
        snackbar.error("保存失败", value.message!, value.statusCode);
      }else{
        onSuccess(value.data);
      }
    });
  }

  static void read({
    required String me,
    required String him,
    required Function() onSuccess
  }) {
    ChatNetService().read(him:him,me:me).then((value){
      if(value.isError()){
        snackbar.error("变更失败", value.message!, value.statusCode);
      }else{
        onSuccess();
      }
    });
  }

  static void history({
    required String me,
    required String him,
    required int page,
    int size=10,
    required Function(dynamic) onSuccess
  }) {
    ChatNetService().history(him:him,me:me,page:page,size: size).then((value){
      if(value.isError()){
        snackbar.error("获取失败", value.message!, value.statusCode);
      }else{
        onSuccess(value.data);
      }
    });
  }
  static void getConv({
    required String u,
    required int page,
    required int size,
    required Function(dynamic) onSuccess
  }) {
    ChatNetService().getConvs(u:u,page:page,size:size).then((value){
      if(value.isError()){
        snackbar.error("获取失败", value.message!, value.statusCode);
      }else{
        onSuccess(value.data);
      }
    });
  }
}