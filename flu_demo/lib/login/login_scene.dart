import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flu_demo/login/Model/user_model.dart';
import 'package:flu_demo/login/code_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../BaseDefine/sq_color.dart';

class LoginScene extends StatefulWidget {
  @override
  _LoginSceneState createState() => _LoginSceneState();
}

class _LoginSceneState extends State<LoginScene> {
  TextEditingController phoneEditer = TextEditingController();
  TextEditingController codeEditer = TextEditingController();
  int coldDownSecond = 0;
  Timer timer;

  fetchSmsCode() async {
    if (phoneEditer.text.length == 0) {
      print('电话号码不能为空');
      return;
    }
    try {
      Response response = await Dio().post(
          'https://neiwang2.ydcfo.com/CXF/rs/direct/sys/user/token/get',
          data: {
            'username': 'jinzhu',
            'password': '123456',
            'deviceType': 'iOS'
          });
      Map result = json.decode(response.toString());
      print(result['data']);
      // Map userMap = json.decode(result['data']);
      var user = new UserModel.fromJson(result['data']);
      UserManager.instance.user = user;
      print('token + ${UserManager.instance.user.token}');

      ///响应数据
    } catch (e) {
      print("11${e}");
    }
  }

  Widget buildBody() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildPhone(),
              SizedBox(
                height: 10,
              ),
              buildCode(),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: SQColor.primary,
                ),
                height: 50,
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    '登录',
                    style: TextStyle(fontSize: 16, color: Color(0xffffffff)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPhone() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: SQColor.paper,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: phoneEditer,
        keyboardType: TextInputType.phone,
        style: TextStyle(fontSize: 14, color: SQColor.darkGray),
        decoration: InputDecoration(
          hintText: '请输入手机号',
          hintStyle: TextStyle(color: SQColor.gray),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildCode() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: SQColor.lightGray,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: codeEditer,
              keyboardType: TextInputType.phone,
              style: TextStyle(fontSize: 14, color: SQColor.darkGray),
              decoration: InputDecoration(
                hintText: '请输出验证码',
                hintStyle: TextStyle(fontSize: 14, color: SQColor.gray),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            color: Color(0xffdae3f2),
            width: 1,
            height: 40,
          ),
          CodeButton(
            onPressed: fetchSmsCode,
            coldDownSeconds: coldDownSecond,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }
}
