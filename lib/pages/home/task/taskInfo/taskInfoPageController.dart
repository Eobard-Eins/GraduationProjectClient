import 'package:client_application/res/staticValue.dart';
import 'package:get/get.dart';

class TaskInfoPageController extends GetxController {
  Rx<String> title="".obs;
  Rx<String> description="".obs;
  Rx<String> date="".obs;
  Rx<double> distance=0.0.obs;
  Rx<int> hotValue=0.obs;
  RxList<String> imgs=RxList();
  Rx<String> avatar="".obs;
  Rx<String> username="".obs;
  Rx<String> account="".obs;
  RxList<String> labels=RxList();
  Rx<int> likes=0.obs;
  Rx<int> dislike=0.obs; 

  @override
  void onInit() {
    super.onInit();
    int id = Get.arguments["id"] as int;
    getInfo(id);
  }

  void getInfo(int id){
    title.value="title";
    description.value="description";
    date.value="2020-01-01";
    distance.value=1115.12;
    hotValue.value=114514;
    avatar.value=staticValue.defaultAvatar;
    username.value="username";
    account.value="123456@qq.com";
    labels=RxList.from(["label1","label2"]);
    likes.value=156;
    dislike.value=12;
  }
}