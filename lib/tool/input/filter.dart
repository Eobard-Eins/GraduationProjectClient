
//输入框输入时过滤掉非法字符，用于onChanged回调中
import 'package:get/get.dart';

class InputFilter{
  static String FilterEmail(String s){
    return s;
  }
  static String FilterNum(String s){
    //print("【Filter】 FilterNum:input: $s");
    if(s.isEmpty) return s;
    if(s.isNum) return s;
    else return s.substring(0,s.length-1);
  }

  static String FilterPassword(String s){

    return s;
  }
  
}