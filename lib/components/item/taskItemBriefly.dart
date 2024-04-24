import 'package:client_application/res/color.dart';
import 'package:flutter/material.dart';

class TaskItemBriefly extends StatelessWidget {

  final String title;
  final String addressName;
  final String time;
  final double point;
  final double? height;
  final double? width;
  final Function()? onTap;
  final List<Widget> actions;

  const TaskItemBriefly({
    super.key, 
    required this.title, 
    required this.addressName, 
    required this.time, 
    required this.point,
    this.height,
    this.width,
    this.onTap,
    required this.actions
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width??320,
      height: height??160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0), // 圆角
        boxShadow: [
          BoxShadow(
            color: Coloors.greyDeep.withOpacity(0.1), // 阴影颜色
            offset: const Offset(0.0, 0.5), // 阴影偏移量
            blurRadius: 1.0, // 阴影模糊半径
            spreadRadius: 1.0, // 阴影扩散半径
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: onTap,
              child: Row(children: [
                Expanded(
                  flex: 19,
                  child: Container(
                    padding: const EdgeInsets.only(top:18,left:15),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex:4,child: 
                          Padding(padding: const EdgeInsets.only(right: 10),child: Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),)
                        ),
                        Expanded(flex:5,
                          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 4),
                            child: Column(children: [
                              Row(children: [
                                const Padding(padding: EdgeInsets.only(right: 3),child:Icon(Icons.gps_fixed_outlined,color: Coloors.greyDeep,size: 12,)),
                                Text(
                                  addressName,
                                  style: const TextStyle(color: Coloors.greyDeep,fontSize: 10),
                                )
                              ],),
                              const Padding(padding:EdgeInsets.only(top: 4)),
                              Row(children: [
                                const Padding(padding: EdgeInsets.only(right: 3),child:Icon(Icons.access_time,color: Coloors.greyDeep,size: 12,)),
                                Text(
                                  "截止至$time前",
                                  style: const TextStyle(color: Coloors.greyDeep,fontSize: 10),
                                )
                              ],)
                            ],)
                          )
                        )
                    ],)
                  )
                ),
                Container(height: 90,width: 1,decoration: const BoxDecoration(color: Coloors.greyLight),),
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: const EdgeInsets.only(right: 5),
                    child:Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.monetization_on_outlined,color: Coloors.mainDark,size: 24,),   
                              Padding(padding: const EdgeInsets.only(top:2,left: 2),
                                child: Text(
                                  point.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SmileySans'
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),)
                  )
                )
              ]),
            )
          ),
          const Divider(height: 0.1,color: Coloors.greyLight,indent: 10,endIndent: 10,),
          Expanded(
            flex: 1,
            child: Container(
              //decoration: BoxDecoration(color: Colors.brown),
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions,),
            ),
          )
        ],
      ),
    );
  }

  static Widget actionButtion(String info,Function()? onTap){
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent, // 透明色
        splashColor: Colors.transparent,
        child: Container(
          decoration: const BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(width: 1.0, color: Coloors.greyDeep), // 描边颜色和宽度
            ),
            borderRadius: BorderRadius.all(Radius.circular(3)),
            // color: Colors.transparent,
          ),
          alignment: Alignment.center,
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(info, style: const TextStyle(fontSize: 12,color: Coloors.greyDeep)),
        ),
      ),
    );
  }
}