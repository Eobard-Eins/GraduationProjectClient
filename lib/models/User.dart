class User {
  late String mailAddress;

  late String? username;

  late String password;

  //性别
  late String? gender;

  //头像
  late String avatar;

  //经纬度

  //积分
  late double point;


  User(
      {required this.mailAddress,
      required this.username,
      required this.password,
      required this.gender,
      required this.avatar,
      required this.point});
  User.create(){
    mailAddress = "";
    password = "";
    avatar="";
    point=0.0;
  }

  User.fromJson(Map<String, dynamic> json) {

    mailAddress = json['email'];
    username = json['username'];
    password = json['password'];
    gender = json['gender'];
    avatar = json['avatar'];
    point = json['point'];
  }
}
