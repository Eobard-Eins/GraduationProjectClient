import 'package:easy_refresh/easy_refresh.dart';

class FootAndHeader {
  static const ClassicFooter footer=ClassicFooter(
            hitOver: true,
            processedDuration: Duration(seconds: 1),
            showMessage: false,
            //文本配置
            processingText: "正在刷新...",
            readyText: "正在刷新...",
            armedText: "释放以刷新",
            dragText: "下拉刷新",
            processedText: "刷新成功",
            failedText: "刷新失败",
            noMoreText: "没有更多了",            
          );

  static const ClassicHeader header =  ClassicHeader(
            hitOver: true,
            processedDuration: Duration(seconds: 1),
            showMessage: false,
            processingText: "正在刷新...",
            readyText: "正在刷新...",
            armedText: "释放以刷新",
            dragText: "下拉刷新",
            processedText: "刷新成功",
            failedText: "刷新失败",
            noMoreText: "没有更多了",
          );
}