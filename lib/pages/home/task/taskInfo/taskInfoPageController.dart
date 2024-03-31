import 'package:client_application/res/staticValue.dart';
import 'package:client_application/tool/timeUtils.dart';
import 'package:get/get.dart';

class TaskInfoPageController extends GetxController {
  Rx<String> title="".obs;
  Rx<String> description="".obs;
  Rx<String> date="".obs;
  Rx<double> distance=0.0.obs;
  Rx<int> hotValue=0.obs;
  RxList<String> imgs=RxList();
  Rx<String> avatar=staticValue.defaultAvatar.obs;
  Rx<String> username="".obs;
  Rx<String> account="".obs;
  Rx<String> loc="".obs;
  Rx<String> locDetail="".obs;
  RxList<String> labels=RxList();

  Rx<bool> like=false.obs;
  Rx<bool> dislike=false.obs;
  @override
  void onInit() {
    super.onInit();
    int id = Get.arguments["id"] as int;
    getInfo(id);
  }

  void getInfo(int id) async{
    await TimeUtils.TimeTestModel(3);
    title.value="一个很长很长很长很长很长很长很长很长很长很长很长很长的实例标题";
    description.value="一个很长很长很长很长很长很长#测试#，很长很长很长很长很长#标签1#很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的文本#标签3# #标签3#";
    date.value="2024-12-31 23:46";
    loc.value="湘潭大学";
    locDetail.value="湖南省湘潭市湘潭大学北苑宿舍区";
    distance.value=1115.12;
    hotValue.value=114514;
    avatar.value=staticValue.defaultAvatar;
    username.value="username";
    account.value="123456@qq.com";
    labels=RxList.from(["测试","标签1","标签2","标签3"]);
    imgs.addAll([staticValue.defaultAvatar]);
  }

  void tapLike(){
    like.value=!like.value;
    if(like.value&&dislike.value) dislike.value=false;
  }
  void tapDislike(){
    dislike.value=!dislike.value;
    if(like.value&&dislike.value) like.value=false;
    imgs.add(staticValue.defaultAvatar);
  }
  void tapChat(){}
}