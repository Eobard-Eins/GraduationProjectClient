import 'package:client_application/utils/localStorage.dart';
import 'package:flutter/material.dart';

class testUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("testUI"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(SpUtils.getString("account"),),
            Text(SpUtils.getString("password"),),
          ],
        )
      ),
    );
  }
}
