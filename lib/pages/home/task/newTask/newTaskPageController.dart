
import 'package:client_application/components/display/snackbar.dart';
import 'package:client_application/services/utils/locationUtils.dart';
import 'package:client_application/services/utils/task/taskUtils.dart';
import 'package:client_application/tool/input/discriminator.dart';
import 'package:client_application/tool/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewTaskPageController extends GetxController {
  Rx<TextEditingController> cityInputController=TextEditingController().obs;
  Rx<TextEditingController> addressInputController=TextEditingController().obs;
  Rx<TextEditingController> titleInputController=TextEditingController().obs;
  Rx<TextEditingController> contentInputController=TextEditingController().obs;
  RxList POIS=RxList();
  Rx<String> locationName="".obs;
  Rx<String> locationAddressName="".obs;
  Rx<String> date="".obs;
  RxList<XFile?> imgs=RxList();
  RxDouble longitude=0.0.obs;
  RxDouble latitude=0.0.obs;
  RxDouble point=0.0.obs;
  Rx<DateTime> time=DateTime.now().obs;

  
  Rx<bool> isUploading=false.obs;
  Rx<bool> isFull=false.obs;
  bool addressFinish=false;
  bool timeFinish=false;
  Rx<bool> pointFinish=false.obs;
  final FocusNode focusNodeOfNotFull = FocusNode();
  final FocusNode focusNodeOfFull = FocusNode();

  @override
  void onInit() {
    super.onInit();
    POIS=RxList();
    imgs=RxList();
    longitude.value=0.0;
    latitude.value=0.0;
    point.value=0.0;
    time.value=DateTime.now();
    locationName.value="";
    locationAddressName.value="";
    date.value="";
    cityInputController.value.clear();
    cityInputController.refresh();
    addressInputController.value.clear();
    addressInputController.refresh();
    titleInputController.value.clear();
    titleInputController.refresh();
    contentInputController.value.clear();
    contentInputController.refresh();

    isFull.value=false;
    isUploading.value=false;
    addressFinish=false;
    timeFinish=false;
    pointFinish.value=false;
  }

  void searchAddress()async{
    POIS.clear();
    var t=await LocationUtils().search(addressInputController.value.text, cityInputController.value.text);
    POIS.addAll(t??[]);
  }
  void upload(){
    isUploading.value=true;
    if(titleInputController.value.text.isEmpty||contentInputController.value.text.isEmpty||(!addressFinish)||(!timeFinish)||(!pointFinish.value)){
      snackbar.error("发布失败", "请完善信息",0);
    }else{
      List<String> tags=Discriminator.getLabels(contentInputController.value.text);
      if(tags.length>10){
        snackbar.error("发布失败", "标签过多，请保持标签数量在10个以内",0);
      }else{
        List<XFile> ls=[];
        for(var i in imgs){
          if(i!=null) ls.add(i);
        }
        TaskUtils.addTask(
          account: SpUtils.getString("account"), 
          title: titleInputController.value.text, 
          content: contentInputController.value.text, 
          tags: tags, 
          addressName: locationName.value, 
          address: locationAddressName.value, 
          lat: latitude.value, 
          lon: longitude.value, 
          time: time.value, 
          imgs: ls, 
          online: latitude.value==91, 
          point: point.value,
          onSuccess: (data){
            isUploading.value=false;
            Get.back();
            snackbar.success("发布成功", "发布委托成功");
          }
        );
        isUploading.value=false;
      }
    }
  }

  void addTag(){
    contentInputController.value.text+=" #";
    contentInputController.refresh();
    if(isFull.value){
      FocusScope.of(Get.context!).requestFocus(focusNodeOfFull);
    }else{
      FocusScope.of(Get.context!).requestFocus(focusNodeOfNotFull);
    }
    
  }
}