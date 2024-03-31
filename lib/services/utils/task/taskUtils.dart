import 'package:client_application/services/connect/TaskNetService.dart';
import 'package:client_application/tool/res/status.dart';
import 'package:get/get.dart';
import 'package:client_application/components/display/snackbar.dart';
class TaskUtils extends GetConnect{

  static getTaskList({
    required String account,
    required int k,
    required String search,
    required double distance,
    required double lat,
    required double lon,
    required Function(List<dynamic>) onSuccess,
  }){
    TaskNetService().getTasks(account,k,search,distance,lat,lon).then((value){
      switch(value.statusCode){
        case Status.taskGetError:
          snackbar.error("获取失败", "请稍后重试", value.statusCode);
          break;
        case Status.userNotExist:
          snackbar.error("获取失败", "当前用户不存在", value.statusCode);
          break;
        case Status.netError:
          snackbar.error("获取失败", "请检查网络设置", value.statusCode);
          break;
        case Status.success:
          onSuccess(value.data);
          break;
        default:
          snackbar.error("获取失败", "请检查网络设置", value.statusCode);
          break;
      }
    });
  }
}