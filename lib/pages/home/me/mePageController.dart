import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/res/staticValue.dart';
import 'package:client_application/services/utils/user/userInfoUtils.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:get/get.dart';
class MePageController extends GetxController{
  Rx<String> username="".obs;
  Rx<String> avatarURL=staticValue.defaultAvatar.obs;
  Rx<double> point=0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // username.value=SpUtils.getString("username");
    // avatarURL.value=SpUtils.getString("avatarURL");
    // point.value=SpUtils.getDouble("point");
    loadData();
  }
  
  void loadData(){
    printInfo(info:"load info of user ${SpUtils.getString("account")}");
    UserInfoUtils.getUserInfo(mail: SpUtils.getString("account"), onSuccess: (u){
      username.value=u.username!;
      avatarURL.value=u.avatar;
      point.value=u.point;
    });
  }

  void gotoHistoryPage()=>Get.toNamed(RouteConfig.taskHistoryPage);
  void gotoAboutPage()=>Get.toNamed(RouteConfig.aboutPage);
  void gotoSettingPage()=>Get.toNamed(RouteConfig.settingPage);
  void gotoMyPublish(int num)=>Get.toNamed(RouteConfig.myPublishPage,arguments: {"initialIndex":num});
  void gotoMyAccess(int num)=>Get.toNamed(RouteConfig.myAccessPage,arguments: {"initialIndex":num});
}