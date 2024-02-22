
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskPageController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  @override
  void onInit() {
    super.onInit();
    searchController.value.clear();
    searchController.refresh();
  }

  void addNewTask() {
  }
  void search() {
  }
  void filter(){

  }
  void tapTask(){
    
  }
}