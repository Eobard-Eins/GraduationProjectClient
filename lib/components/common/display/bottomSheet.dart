import 'package:client_application/components/common/display/optionInSheet.dart';
import 'package:client_application/components/common/display/shortHeadBar.dart';
import 'package:flutter/material.dart';

//设置底部选择弹窗的各选项和标题，非组件，为触发事件，事件包括create()，即创建弹窗
class BottomSelectSheet {
  final String title;
  final List<OptionInSheet> options;
  final BuildContext context;

  const BottomSelectSheet({required this.title, required this.options, required this.context});

  create(){
    return showModalBottomSheet(
      context: context, 
      //设置圆角
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ShortHeadBar(),
            Row(
              children: [
                const SizedBox(width: 20,),
                Text(title,style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
                const Spacer(),
                IconButton(
                  onPressed: ()=>Navigator.pop(context), 
                  icon: const Icon(Icons.close,color: Colors.grey,),
                  style: const ButtonStyle(
                    //取消水波纹
                    splashFactory: NoSplash.splashFactory,
                  ),
                ),
                const SizedBox(width: 15,),
              ],
            ),
            Divider(color: Colors.grey.withOpacity(0.4),height: 2,),
            Column(
              children: options,
            )
          ],
        );
      }
    );
  }

}