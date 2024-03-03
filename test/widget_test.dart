// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/pages/loginAndUserInfo/login/loginPage/loginPageUI.dart';
import 'package:client_application/services/UserNetService.dart';
import 'package:client_application/models/User.dart';
import 'package:client_application/utils/discriminator.dart';
import 'package:client_application/utils/localStorage.dart';
import 'package:client_application/utils/locationUtils.dart';
import 'package:client_application/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:client_application/main.dart';
import 'package:get/get.dart';
bool initJudge(){
    return SpUtils.getBool("isLogin");
  }
void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    print((await LocationUtils().search("韩城", "禹州市")).toString());
  });

  
  
}
