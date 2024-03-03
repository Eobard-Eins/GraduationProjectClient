import 'dart:async';

import 'package:client_application/res/color.dart';
import 'package:client_application/utils/staticValue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
 
class LocationUtils extends GetConnect {
    static final AMapFlutterLocation flutterLocation = AMapFlutterLocation();
    static PermissionStatus? permissionStatus;
    static late StreamSubscription<Map<String, Object>> locationListener;

    LocationUtils._internal();
    factory LocationUtils() => _instance;
    static final LocationUtils _instance = LocationUtils._internal();
    static LocationUtils getInstance() => _instance;

    Future search(String add,String region,{int pageSize=10})async{
      var res= await get("https://restapi.amap.com/v5/place/text",query: {"keywords":add,"region":region,"city_limit":true.toString(),"page_size":pageSize.toString(),"key":staticValue.GaoDeKeyOfWeb}).then((value){
        if(!value.isOk){
          printInfo(info:"网络异常，不能连接服务器");
          return [];
        }else{
          printInfo(info:"POI API请求成功");
          List pois=value.body['pois'];
          int k=int.parse(value.body['count']);
          List ls=[];
          for(int i=0;i<k;i++){
            
            String address="${pois[i]['pname']}-${pois[i]['cityname']}-${pois[i]['adname']}-${pois[i]['address']}";

            String name=pois[i]['name'];

            String location=pois[i]['location'];
            double longitude=double.parse(location.split(',')[0]);
            double latitude=double.parse(location.split(',')[1]);
            //printInfo(info:{"name":name, "address":address, "longitude":longitude, "latitude":latitude}.toString());
            ls.add({"name":name, "address":address, "longitude":longitude, "latitude":latitude});
          }
          return ls;
        }
      }).onError((error, stackTrace){
        printError(info:"POI API请求失败,$error");
        return [];
      });
      return res;
    }
 
    
    static getLocation (Function(dynamic result) onLocationChanged,{bool onceLocation=false, String androidKey=staticValue.GaoDeKeyOfAndroid, String iosKey=staticValue.GaoDeKeyOfIos}){
        _setPrivacy(androidKey, iosKey);
        _requestPermission(onceLocation,onLocationChanged);
    }
 
    static void stopLocation (){
        _stopLocation();
    }
 
 
    //  设置高德apiKey
    static void _setPrivacy (String androidKey, String iosKey){
        AMapFlutterLocation.setApiKey(
            androidKey,
            iosKey
        );
        AMapFlutterLocation.updatePrivacyAgree(true);
        AMapFlutterLocation.updatePrivacyShow(true, true);
    }
 
    //  获取系统权限
    static _requestPermission (bool onceLocation,Function(dynamic result) onLocationChanged) async {
        permissionStatus = await Permission.location.status;
        if(permissionStatus == PermissionStatus.granted) {
            _requestLocation(onceLocation,onLocationChanged);
        } else {
            permissionStatus = await Permission.location.request();
            switch (permissionStatus) {
                case PermissionStatus.denied:
                     Get.snackbar("获取失败", "请开启位置权限",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
                     break;
                case PermissionStatus.granted:
                     _requestLocation(onceLocation,onLocationChanged);
                     break;
                case PermissionStatus.limited:
                     Get.snackbar("获取失败", "请开启位置权限",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
                     break;
                default:
                     Get.snackbar("获取失败", "请开启位置权限",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
                     break;
            }     
 
        }
    }
 
    //  设置配置项
    static void _setLocationOption (bool onceLocation) {
        AMapLocationOption locationOption = AMapLocationOption();
        ///是否单次定位
        locationOption.onceLocation=onceLocation;

        ///是否需要返回逆地理信息
        locationOption.needAddress = true;

        ///逆地理信息的语言类型
        locationOption.geoLanguage = GeoLanguage.ZH;

        //设置定位模式为高精度
        locationOption.locationMode=AMapLocationMode.Hight_Accuracy;

        locationOption.desiredLocationAccuracyAuthorizationMode =
            AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

        locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

        flutterLocation.setLocationOption(locationOption);
    }
 
    //  获取实时位置
    static _requestLocation (bool onceLocation,Function(dynamic result) onLocationChanged) {
        _setLocationOption(onceLocation);
        flutterLocation.startLocation();
        locationListener = flutterLocation.onLocationChanged().listen((result){
            onLocationChanged(result);
        });
        locationListener.onError((e){
          Get.snackbar("获取失败", "请稍后重试",icon: const Icon(Icons.error_outline,color: Coloors.red,),shouldIconPulse:false);
          _stopLocation();
        });
    }
 
    //  停止定位
    static void _stopLocation (){
        flutterLocation.destroy();
        locationListener.cancel();
    }
 
}