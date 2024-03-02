import 'package:client_application/components/common/display/scrollableText.dart';
import 'package:flutter/material.dart';

class AgreementPage extends StatelessWidget {
  const AgreementPage({super.key});
  final String info =
      """本平台为湘潭大学毕业设计作品，暂不作为商用用途，暂不开源！""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //标题
          title: const Text(
            "用户须知",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: ScrollableText(text: info)
    );
  }
}
