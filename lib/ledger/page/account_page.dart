import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountState();
  }
}

const SCENE_SIGN_IN = 0; // 登录
const SCENE_SIGN_UP = 1; // 注册
const SCENE_FIND_PASSWORD = 2; // 忘记密码

class _AccountState extends State<AccountPage> {
  var _scene = SCENE_SIGN_IN;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Image.asset(
              "graphics/image_splash.jpg",
              fit: BoxFit.cover,
            ),
            constraints: new BoxConstraints.expand(), // 充满父布局
          ),
          _getBodyPage(),
        ],
      ),
    );
  }

  _getBodyPage() {
    switch (_scene) {
      case SCENE_SIGN_IN:
        return SignInPage();
      case SCENE_SIGN_UP:
        return SignUpPage();
      case SCENE_FIND_PASSWORD:
        return FindPasswordPage();
    }
  }
}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => new _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidate: true, //开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: true,
                  controller: _usernameController,
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      icon: Icon(Icons.person)),
                  // 校验用户名
                  validator: (v) {
                    return v.trim().length > 0 ? null : "用户名不能为空";
                  }),
              TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "您的登录密码",
                      icon: Icon(Icons.lock)),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return v.trim().length > 5 ? null : "密码不能少于6位";
                  }),
              // 登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("登录"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          //在这里不能通过此方式获取FormState，context不对
                          //print(Form.of(context));

                          // 通过_formKey.currentState 获取FormState后，
                          // 调用validate()方法校验用户名密码是否合法，校验
                          // 通过后再提交数据。
                          if ((_formKey.currentState as FormState).validate()) {
                            //验证通过提交数据
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("登录");
  }
}

class FindPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("忘记密码");
  }
}
