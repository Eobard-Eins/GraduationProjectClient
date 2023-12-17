
import 'package:client_application/components/common/button/squareTextButton.dart';
import 'package:client_application/components/common/input/textField.dart';
import 'package:client_application/config/RouteConfig.dart';
import 'package:client_application/res/color.dart';
import 'package:client_application/utils/filter.dart';
import 'package:flutter/material.dart';

//用于修改密码前、注册账号前验证手机号
class SetPasswordPage extends StatefulWidget {
  const SetPasswordPage({super.key});

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  late TextEditingController _passwordController;
  late TextEditingController _passwordAgainController;

  bool _obscure = true;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _passwordAgainController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordAgainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //标题
          title: const Text(
            "设置密码",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Coloors.purple,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
              child:Text(
                "密码长度应在4~16位，可使用字母、数字、符号组合",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //密码第一次输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 0),
              child: UserTextFieldWidget(
                controller: _passwordController,
                onChanged: (value) {
                  setState(() {
                    _passwordController.text = InputFilter.FilterPassword(value);
                  });
                },
                readOnly: false,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                maxLength: 16,
                //textInputAction: TextInputAction.next,
                hintText: "请输入密码",
                suffixIconConstraints: const BoxConstraints(minHeight: 22),
                suffixIcon: _passwordController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          //清空输入框
                          _passwordController.clear();
                          setState(() {
                            _passwordController.clear();
                          });
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
            //密码第二次输入
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 0),
              child: UserTextFieldWidget(
                controller: _passwordAgainController,
                onChanged: (value) {
                  setState(() {
                    _passwordAgainController.text = InputFilter.FilterPassword(value);
                  });
                },
                readOnly: false,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscure,
                maxLength: 16,
                textInputAction: TextInputAction.done,
                //TODO:
                onEditingComplete: (_passwordController.text.isEmpty || _passwordAgainController.text.isEmpty)? null: onTapNext,
                hintText: "请重复输入密码",
                suffixIconConstraints: const BoxConstraints(minHeight: 22),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: _passwordAgainController.text.isEmpty
                          ? null
                          : () {
                              //显示密码
                              setState(() {
                                _obscure = !_obscure;
                              });
                            },
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        color: _passwordAgainController.text.isEmpty
                            ? Colors.transparent
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        //下一步
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
          child:SquareTextButton(
            text: "下一步", 
            onTap: (_passwordController.text.isEmpty ||
                    _passwordAgainController.text.isEmpty)
                ? null
                : onTapNext)
        )
      );
  }

  void onTapNext() {
    print("next");
    Navigator.of(context).pushReplacementNamed(RouteConfig.setNameAndAvatarPage);
  }

  void onTapAgreement() {
    print("trunToAgreement");
    Navigator.of(context).pushNamed(RouteConfig.agreementInfoPage);
  }
}
