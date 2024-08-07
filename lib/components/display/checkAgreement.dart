import 'package:client_application/res/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CheckAgreement extends StatelessWidget {
  final void Function(bool?)? onChanged;
  final bool init;
  final void Function()? onTapAgreeMent;

  const CheckAgreement({super.key, required this.onChanged, required this.init,required this.onTapAgreeMent});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: init,
                onChanged: onChanged,
                activeColor: Coloors.main,
                checkColor: Colors.white,
                splashRadius: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

              ),
              Text.rich(
                TextSpan(
                  text: "我已阅读并同意",
                  style: const TextStyle(
                    color: Coloors.greyDeep,
                    fontSize: 12,
                    fontWeight:  FontWeight.normal,
                  ),
                  children: [
                    TextSpan(
                      text: "《用户协议》",
                      style: const TextStyle(
                        color: Coloors.main,
                        fontSize: 12,
                        fontWeight:  FontWeight.normal,
                      ),
                      recognizer: TapGestureRecognizer()
                       ..onTap = onTapAgreeMent,
                    ),
                  ],
                ),

              )
            ],
          )
        );
  }
}