import 'package:client_application/components/common/scrollableText.dart';
import 'package:flutter/material.dart';

class AgreementPage extends StatelessWidget {
  const AgreementPage({super.key});
  final String info =
      """路由的概念由来已久，包括网络路由、后端路由，到现在广为流行的前端路由。无论路由的概念如何应用，它的核心是一个路由映射表。比如：名字 detail 映射到 DetailPage 页面等。有了这个映射表之后，我们就可以方便的根据名字来完成路由的转发（在前端表现出来的就是页面跳转）

路由(Route)在移动开发中通常指页面（Page），这跟web开发中单页应用的Route概念意义是相同的，Route在Android中通常指一个Activity，在iOS中指一个ViewController。所谓路由管理，就是管理页面之间如何跳转，通常也可被称为导航管理。Flutter中的路由管理和原生开发类似，无论是Android还是iOS，导航管理都会维护一个路由栈，路由入栈(push)操作对应打开一个新页面，路由出栈(pop)操作对应页面关闭操作，而路由管理主要是指如何来管理路由栈。路由的概念由来已久，包括网络路由、后端路由，到现在广为流行的前端路由。无论路由的概念如何应用，它的核心是一个路由映射表。比如：名字 detail 映射到 DetailPage 页面等。有了这个映射表之后，我们就可以方便的根据名字来完成路由的转发（在前端表现出来的就是页面跳转）

路由(Route)在移动开发中通常指页面（Page），这跟web开发中单页应用的Route概念意义是相同的，Route在Android中通常指一个Activity，在iOS中指一个ViewController。所谓路由管理，就是管理页面之间如何跳转，通常也可被称为导航管理。Flutter中的路由管理和原生开发类似，无论是Android还是iOS，导航管理都会维护一个路由栈，路由入栈(push)操作对应打开一个新页面，路由出栈(pop)操作对应页面关闭操作，而路由管理主要是指如何来管理路由栈。路由的概念由来已久，包括网络路由、后端路由，到现在广为流行的前端路由。无论路由的概念如何应用，它的核心是一个路由映射表。比如：名字 detail 映射到 DetailPage 页面等。有了这个映射表之后，我们就可以方便的根据名字来完成路由的转发（在前端表现出来的就是页面跳转）

路由(Route)在移动开发中通常指页面（Page），这跟web开发中单页应用的Route概念意义是相同的，Route在Android中通常指一个Activity，在iOS中指一个ViewController。所谓路由管理，就是管理页面之间如何跳转，通常也可被称为导航管理。Flutter中的路由管理和原生开发类似，无论是Android还是iOS，导航管理都会维护一个路由栈，路由入栈(push)操作对应打开一个新页面，路由出栈(pop)操作对应页面关闭操作，而路由管理主要是指如何来管理路由栈。路由的概念由来已久，包括网络路由、后端路由，到现在广为流行的前端路由。无论路由的概念如何应用，它的核心是一个路由映射表。比如：名字 detail 映射到 DetailPage 页面等。有了这个映射表之后，我们就可以方便的根据名字来完成路由的转发（在前端表现出来的就是页面跳转）

路由(Route)在移动开发中通常指页面（Page），这跟web开发中单页应用的Route概念意义是相同的，Route在Android中通常指一个Activity，在iOS中指一个ViewController。所谓路由管理，就是管理页面之间如何跳转，通常也可被称为导航管理。Flutter中的路由管理和原生开发类似，无论是Android还是iOS，导航管理都会维护一个路由栈，路由入栈(push)操作对应打开一个新页面，路由出栈(pop)操作对应页面关闭操作，而路由管理主要是指如何来管理路由栈。路由的概念由来已久，包括网络路由、后端路由，到现在广为流行的前端路由。无论路由的概念如何应用，它的核心是一个路由映射表。比如：名字 detail 映射到 DetailPage 页面等。有了这个映射表之后，我们就可以方便的根据名字来完成路由的转发（在前端表现出来的就是页面跳转）

路由(Route)在移动开发中通常指页面（Page），这跟web开发中单页应用的Route概念意义是相同的，Route在Android中通常指一个Activity，在iOS中指一个ViewController。所谓路由管理，就是管理页面之间如何跳转，通常也可被称为导航管理。Flutter中的路由管理和原生开发类似，无论是Android还是iOS，导航管理都会维护一个路由栈，路由入栈(push)操作对应打开一个新页面，路由出栈(pop)操作对应页面关闭操作，而路由管理主要是指如何来管理路由栈。""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //标题
          title: const Text(
            "用户协议",
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
