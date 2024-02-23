class TaskItemInfo{
  late String title;
  late double point;
  late String time;
  late String location;
  late String labels;
  late int hotValue;
  late int id;

  TaskItemInfo({required this.id,required this.title,required this.point,required this.time,required this.location,required this.labels,required this.hotValue});
  TaskItemInfo.bottom(){
    id=-1;
  }
}