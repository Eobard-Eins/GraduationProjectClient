class TimeUtils{
  static Future TimeTestModelWithFunc(int init,Function()? f)async{//模拟网络请求延时
    //模拟延时
    return Future.delayed(Duration(seconds: init),f);
  }
  static Future TimeTestModel(int init)async{//模拟网络请求延时
    //模拟延时
    return Future.delayed(Duration(seconds: init));
  }
}