import 'package:client_application/components/display/shortHeadBar.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/utils/locationUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class NewTaskPageController extends GetxController {
  Rx<TextEditingController> cityInputController=TextEditingController().obs;
  Rx<TextEditingController> addressInputController=TextEditingController().obs;
  RxList POIS=RxList();
  RxDouble longitude=0.0.obs;
  RxDouble latitude=0.0.obs;

  @override
  void onInit() {
    super.onInit();
    POIS=RxList();
    longitude.value=0.0;
    latitude.value=0.0;
    cityInputController.value.clear();
    cityInputController.refresh();
    addressInputController.value.clear();
    addressInputController.refresh();
  }

  void searchAddress()async{
    POIS.clear();
    POIS.addAll(await LocationUtils().search(addressInputController.value.text, cityInputController.value.text));
  }
}