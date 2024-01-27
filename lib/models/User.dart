class User {
  late String phone;

  late String? username;

  late String password;

  //性别
  late String? gender;

  //头像
  late String avatar;

  //经纬度
  late double? longitude;
  late double? latitude;

  //积分
  late double point;


  User(
      {required this.phone,
      required this.username,
      required this.password,
      required this.gender,
      required this.avatar,
      required this.longitude,
      required this.latitude,
      required this.point});
  User.create(){
    phone = "";
    password = "";
    avatar="";
    point=0.0;
  }

  User.fromJson(Map<String, dynamic> json) {

    phone = json['phone'];
    username = json['username'];
    password = json['password'];
    gender = json['gender'];
    avatar = json['avatar'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    point = json['point'];
  }
}
