import 'package:client_application/components/user/avatarFromNet.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/utils/staticValue.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final Function()? ontap;
  final double? width;
  final double? height;
  final String? avatarUrl;
  final String title;
  final double point;
  final String time;
  final String? location;
  final String labels;
  final int hotValue;

  const TaskItem({
    super.key,
    required this.ontap,
    this.avatarUrl,
    required this.time,
    this.location,
    required this.title,
    required this.point,
    required this.labels,
    required this.hotValue,
    this.width,
    this.height,
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
      child: InkWell(
        onTap: ontap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), // 圆角
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // 阴影颜色
                offset: const Offset(0.0, 3.0), // 阴影偏移量
                blurRadius: 8.0, // 阴影模糊半径
                spreadRadius: 2.0, // 阴影扩散半径
              ),
            ],
          ),
          child: Row(children: [
            Expanded(
              flex: 72,
              child: Container(
                width: (width??360.0),
                height: height??140.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),
                ),
                child: Column(children: [
                  Container(
                    height: 55,
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child:Row(
                      children: [
                        AvatarFromNet(
                          width: 30,
                          height: 30,
                          boxShape: BoxShape.circle,
                          imageUrl: avatarUrl??staticValue.defaultAvatar
                        ),
                        Expanded(
                          child: Padding(padding: const EdgeInsets.only(left: 10),
                            child:Text(
                              title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'SmileySans',
                                height: 1.2
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              
                            ),
                          )
                        )
                      ],
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 180,
                      height: 80,
                      padding: const EdgeInsets.only(left: 10,right: 0,top: 20,bottom: 10),
                      
                      child:Column(
                        children: [
                        const Row(children: [
                          
                          Padding(padding: EdgeInsets.only(right: 2,bottom: 0),child: Icon(Icons.label_outline,color: Coloors.main,size: 18,),),
                          Text("标签",style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SmileySans',
                          ),)
                        ],),
                        const Padding(padding: EdgeInsets.only(top: 3)),
                        const Divider(height:0.1,indent:2,endIndent: 15,color: Coloors.greyLight,),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 15,top: 4,right: 20),
                          child: Text(
                            labels,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Coloors.greyDeep,
                              fontFamily: 'SmileySans',
                              fontWeight: FontWeight.normal
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                        ),)
                      ],)
                    ),
                    Container(
                      height: 30,
                      width: 0.5,
                      decoration: const BoxDecoration(color: Color.fromARGB(255, 181, 181, 181)),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left:0,top: 20,bottom: 10),
                      width: 80,
                      height: 80,
                      child: Column(
                        children: [
                        const SizedBox(
                          width: 45,
                          child: Row(children: [
                            
                            Padding(padding: EdgeInsets.only(right: 2,bottom: 2),child: Icon(Icons.whatshot_outlined,color: Colors.red,size: 16,),),
                            Text("热度",style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'SmileySans',
                            ),)
                          ],),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 3)),
                        const Divider(height:0.1,indent: 15,endIndent: 15,color: Coloors.greyLight),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 20,top: 4,right: 20),
                          child: Text(
                            hotValue.toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Coloors.greyDeep,
                              fontFamily: 'SmileySans',
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1
                            ),
                            maxLines: 1,
                        ),)
                      ],),
                    )
                  ],)
                ]),
              ),
            ),
            
            Expanded(
              flex: 28,
              child:Container(
                width: (width??365.0),
                height: height??140.0,
                decoration: const BoxDecoration(
                  color: Coloors.mainDark,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
                ),
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.monetization_on_outlined,color: Coloors.gold,size: 24,),   
                        Padding(padding: const EdgeInsets.only(left:3),
                          child: Text(
                            point.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SmileySans'
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top:10,right: 0),
                    child: Column(
                      children: [
                      Row(
                        children: [
                          const Padding(padding: EdgeInsets.only(left:10)),
                          const Icon(Icons.gps_fixed_outlined,color: Coloors.greyLight,size: 12,),
                          Padding(padding: const EdgeInsets.only(left:3),
                            child:Text(location??"---",style: const TextStyle(fontFamily: 'SmileySans',color: Colors.white,fontSize: 10,letterSpacing: 1),),
                          )
                      ],),
                      const Padding(padding: EdgeInsets.symmetric(vertical:3)),
                      Row(
                        children: [
                          const Padding(padding: EdgeInsets.only(left:10)),
                          const Padding(padding: EdgeInsets.only(bottom: 10),child: Icon(Icons.access_time,color: Coloors.greyLight,size: 12,),),
                          Padding(padding: const EdgeInsets.only(left:3),
                            child:Text(
                              time,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                letterSpacing: 1,
                                height: 1.1,
                                fontFamily: 'SmileySans'
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                      ],),
                    ]),
                  )
                ],)
              )
            )
          ],)
        ),
        
      ),
    );
  }
}