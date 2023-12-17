
//输入框输入时过滤掉非法字符，用于onChanged回调中
class InputFilter{
  static String FilterNum(String s){
    //print("【Filter】 FilterNum:input: $s");
    if(s.isEmpty) return s;
    String lastChar=s[s.length-1].toString();
    //print("【Filter】 FilterNum:lastChar: $lastChar");
    if(RegExp('[0-9]').hasMatch(lastChar)) {
      //print("1221221");
      return s;
    }
   // print("555555");
    return s.substring(0,s.length-1);
  }
  static String FilterPassword(String s){
    return s;
  }
}