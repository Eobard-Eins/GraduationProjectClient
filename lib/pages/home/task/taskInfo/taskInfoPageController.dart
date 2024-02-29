import 'package:get/get.dart';

class TaskInfoPageController extends GetxController {
  Rx<String> id="".obs;
  @override
  void onInit() {
    super.onInit();
    getInfo();
  }

  void getInfo(){
    int id1 = Get.arguments["id"] as int;
    id.value= id1.toString();
  }
}