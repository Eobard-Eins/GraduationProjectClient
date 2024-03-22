
import 'package:flutter/material.dart';

class AgreementPage extends StatelessWidget {
  const AgreementPage({super.key});
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
        body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Text(
            """本平台为湘潭大学本科毕业设计作品，暂不作为商用用途，暂不开源！""",
            style: TextStyle(
                color: Color.fromARGB(255, 94, 94, 94),
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
          ),
        ),
      )
    );
  }
}
