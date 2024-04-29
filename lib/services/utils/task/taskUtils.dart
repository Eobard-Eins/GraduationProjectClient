
import 'package:client_application/components/display/uploadingDialog.dart';
import 'package:client_application/services/connect/TaskNetService.dart';
import 'package:get/get.dart';
import 'package:client_application/components/display/snackbar.dart';
import 'package:image_picker/image_picker.dart';
class TaskUtils extends GetConnect{

  static getTaskList({
    required String account,
    required int k,
    required String search,
    required double distance,
    required double lat,
    required double lon,
    required Function(List<dynamic>) onSuccess,
    required Function() onError,
  }){
    TaskNetService().getTasks(account,k,search,distance,lat,lon).then((value){
      if(value.isError()){
        onError();
        snackbar.error("获取失败", value.message!, value.statusCode);
      }else{
        onSuccess(value.data);
      }
    });
  }

  static getTask({
    required int id,
    required String account,
    required Function(Map<String, dynamic>) onSuccess,
  }){
    TaskNetService().getTask(id,account).then((value){
      if(value.isError()){
        snackbar.error("获取失败", value.message!, value.statusCode);
      }else{
        onSuccess(value.data);
      }
    });
  }

  static addTask({
    required String account,
    required String title,
    required String content,
    required List<String> tags,
    required String addressName,
    required String address,
    required double lat,
    required double lon,
    required DateTime time,
    required List<XFile> imgs,
    required bool online,
    required double point,
    required Function onSuccess,
  }){
    UploadingDialog.show();
    TaskNetService().addNewTask(account, title, content, tags, addressName, address, lat, lon, time, imgs, online, point).then((value) {
      UploadingDialog.hide();
      if(value.isError()){
        snackbar.error("发布失败", value.message!, value.statusCode);
      }else{
        onSuccess(value.data);
      }
    });
  }
  static like({
    required int id,
    required String account,
    required Function onSuccess,
  }){
    UploadingDialog.show();
    TaskNetService().like(id,account).then((value){
      UploadingDialog.hide();
      if(value.isError()){
        snackbar.error("点赞失败", value.message!, value.statusCode);
      }else{
        onSuccess();
      }
    });
  }
  static dislike({
    required int id,
    required String account,
    required Function onSuccess,
  }){
    UploadingDialog.show();
    TaskNetService().dislike(id,account).then((value){
      UploadingDialog.hide();
      if(value.isError()){
        snackbar.error("点踩失败", value.message!, value.statusCode);
      }else{
        onSuccess();
      }
    });
  }

  static getHistory({
    required int num,
    required String account,
    required Function(List<dynamic>) onSuccess,
  }){
    TaskNetService().getHistory(account,num).then((value){
      if(value.isError()){
        snackbar.error("获取失败", value.message!, value.statusCode);
      }else{
        onSuccess(value.data);
      }
    });
  }

  static requestTask({
    required int id,
    required String account,
    required Function onSuccess,
  }){
    UploadingDialog.show();
    TaskNetService().requestTask(account,id).then((value){
      UploadingDialog.hide();
      if(value.isError()){
        snackbar.error("申请失败", value.message!, value.statusCode);
      }else{
        onSuccess();
      }
    });
  }
  static accessTask({
    required int id,
    required String account,
    required Function onSuccess,
  }){
    UploadingDialog.show();
    TaskNetService().accessTask(id,account).then((value){
      UploadingDialog.hide();
      if(value.isError()){
        snackbar.error("接受失败", value.message!, value.statusCode);
      }else{
        onSuccess();
      }
    });
  }
  static getTasksByPublicUser({
    required String account,
    required int status,
    required Function(List<dynamic>) onSuccess,
    required Function() onError,
  }){
    TaskNetService().getTasksByPublicUser(account,status).then((value){
      if(value.isError()){
        snackbar.error("获取失败", value.message!, value.statusCode);
        onError();
      }else{
        onSuccess(value.data);
      }
    });
  }
  static getTasksByAccessUser({
    required String account,
    required int status,
    required Function(List<dynamic>) onSuccess,
    required Function() onError,
  }){
    TaskNetService().getTasksByAccessUser(account,status).then((value){
      if(value.isError()){
        snackbar.error("获取失败", value.message!, value.statusCode);
        onError();
      }else{
        onSuccess(value.data);
      }
    });
  }
  static getAllRequestWithTask({
    required int id,
    required Function(List<dynamic>) onSuccess,
  }){
    TaskNetService().getAllRequestWithTask(id).then((value){
      if(value.isError()){
        snackbar.error("获取失败", value.message!, value.statusCode);
      }else{
        onSuccess(value.data);
      }
    });
  }
  static setStatus({
    required int id,
    required int status,
    required Function onSuccess,
  }){
    UploadingDialog.show();
    TaskNetService().setStatus(id,status).then((value){
      UploadingDialog.hide();
      if(value.isError()){
        snackbar.error("变更失败", value.message!, value.statusCode);
      }else{
        onSuccess();
      }
    });
  }
}