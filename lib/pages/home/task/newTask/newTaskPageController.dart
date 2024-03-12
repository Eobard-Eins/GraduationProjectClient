
import 'package:client_application/services/locationUtils.dart';
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
  Rx<String> date="".obs;
  RxList<XFile?> imgs=RxList();
  RxDouble longitude=0.0.obs;
  RxDouble latitude=0.0.obs;
  Rx<DateTime> time=DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    POIS=RxList();
    imgs=RxList();
    longitude.value=0.0;
    latitude.value=0.0;
    time.value=DateTime.now();
    locationName.value="";
    date.value="";
    cityInputController.value.clear();
    cityInputController.refresh();
    addressInputController.value.clear();
    addressInputController.refresh();
    titleInputController.value.clear();
    titleInputController.refresh();
    contentInputController.value.clear();
    contentInputController.refresh();
  }

  void searchAddress()async{
    POIS.clear();
    var t=await LocationUtils().search(addressInputController.value.text, cityInputController.value.text);
    POIS.addAll(t??[]);
  }
  void upload(){}

  void addTag(){
    contentInputController.value.text+=" #";
    contentInputController.refresh();
  }
}