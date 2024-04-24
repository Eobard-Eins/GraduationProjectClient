class TaskItemInfo{
  late String title;
  late double point;
  late String time;
  late String location;
  late String labels;
  late int hotValue;
  late int id;
  late String avatar;
  late String address;
  late String addressName;

  TaskItemInfo({required this.id,required this.title,required this.point,required this.time,required this.location,required this.labels,required this.hotValue,required this.avatar}){
    address="";
    addressName="";
  }
  TaskItemInfo.brief({required this.id, required this.title, required this.point, required this.time, required this.addressName}){
    location="";
    labels="";
    hotValue=0;
    avatar="";
    address=""; 
  }
  TaskItemInfo.bottom(){
    id=-1;
  }
}