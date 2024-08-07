# **湘潭大学计科毕设-基于推荐算法的委托服务平台（客户端部分）**

# 开发记录(部分)
>## 2023/12/15
>- **记录**：设置密码页面可用于`新账号注册`、`设置密码与忘记密码2处`，后续导航分别为`个人资料设置`、`返回原页面`，来处为`新账号验证码登录`、`手机号验证`。新账号注册信息会导向个人资料设置，其余返回原页面。
>- **记录**导航到设置密码页和头像用户名页时需传入参数`arguments: {'needSetInfo':true,'account':phoneControllerText.value}`,跳转验证页需`arguments: {'newUser':false}`,needSetInfo代表是否需要后续信息设置

>## 2023/12/16
>- **记录**输入框的next动作在出现后缀按钮后失效，会定位到后缀按钮上；输入框可以进行输入有效性检查，可行性未测试
>> ### 2023/12/18：
>>- 将next动作改为done，暂时不必考虑该问题

>## 2023/12/21
>- **记录**：改用GetX进行`路由和状态管理`，初步测试成功。
>- **记录**：需注意的是，该组件在对一个类进行`.obs`操作后，对该类中的变量进行赋值操作，不算作对监听的该类的值进行修改，不能触发Obx()更新。
>> ### 2023/12/23: 
>>- 查阅文档，发现更新自定义类的.obs的方法，即使用`类.refresh()`手动通知刷新改变，验证码登录页和密码登录页的分离已经完成，懒得更新，保留旧方法
>- **记录**：将定义在Controller中的函数作为组件更新依据是不能成功更新的

>## 2023/12/23
>- **记录**：完成了login相关页面的逻辑与UI的分离，但不彻底，下一步应完成弹窗组件，不然后续的分离可能会大改
>> ### 2023/12/24: 
>>- `弹窗`完成，存在新的弹窗触发时不会挤掉旧的弹窗的问题，要等旧的消失

>## 2023/12/24
>- **记录**：cookie的设计应该尽早进行，后期再加入可能会难度大幅增加
>> ### 2023/12/26: 
>>- 本地的持久化存储器有两种，`shared_preferences`适用于简单情形，采用它实现存储cookies；sqfite则类似数据库，适用复杂数据本地存储，比如后续的聊天记录

>## 2023/12/27
>- **记录**：网络服务模块使用GetX的put、find函数有明显卡顿，现采用单例模式凑活用。
>- **记录**：考虑到通信时可能传输各种数据，尤其是为保证网络请求耗时尽可能小，一般要尽可能少的请求，则一次请求尽量一次性获取所需信息最好，但是这种方法获取和发送的信息总是十分冗杂，为减少通信信息和条件判断时间损耗，使用`状态码`代表实际中的各种情况，为了方便，前后端应使用同一套码表

>## 2024/1/12
>- **问题**：VerifyPhonePage跳转设置密码页时出现`REPLACE ROUTE null`和`NEW ROUTE null`，其余跳转暂未发现

>## 2024/1/12
>- **记录**：密码格式未确定，前端因通信格式问题进展不顺，尤其是不知道推荐算法需要什么参数，拟先转后端开发，前端暂且搁置

>## 2024/1/20
>- **记录**：利用cookie或token进行自动登录还要考虑网页和windows端，有点麻烦，直接在客户端本地存储一个最后登录时间，验证是否超时算了

>## 2024/1/22
>- **记录**：手机验证码登录可以往后面顺延一下，包括测试的时候直接在数据库中添加用户即可。头像也不存本地了，用一次请求一次

>## 2024/1/26
>- **记录**：关于消息队列，用于不需返回的请求，比如验证码；如向oss服务器存入文件，文件本体不便于通过消息队列通知，且需要确定是否存入，不适合用消息队列。
>- **问题**：Spring不能执行更新，须在service层加`@Transactional`注释
>- **记录**：若在注册时不设置初始兴趣标签，则依然存在冷启动问题，此时基于内容的推荐仅比协同过滤多解决了新物品的推荐问题；若设置初始兴趣标签，则推荐算法可利用该标签进行初始化，可以一定程度上缓解冷启动，但初始依然不太准确；搜索关键词可用于更新用户特征向量

>## 2024/1/27
>- **记录**：出现问题：无法调试运行，但可以profile模式运行，原因不明，新建项目同样无法运行

>## 2024/2/22
>- **记录**：标题应在30字符内，label在7个字符内, 用户名8个字

>## 2024/3/8
>- **问题**：发布页图片超出屏幕右侧37像素点，图片未加载出来时的背景颜色未设置
>- **回复**：已解决

>## 2024/3/11
>- **问题**：点赞数不用统计，仅作hotValue值统计
>- **回复**
