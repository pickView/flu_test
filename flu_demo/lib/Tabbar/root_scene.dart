import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flu_demo/BaseDefine/sq_color.dart';
import 'package:flu_demo/Mine/me_scene.dart';
import 'package:flu_demo/NetWork/http_request.dart';
import 'package:flu_demo/Third/wechat_manager.dart';
import 'package:flu_demo/login/Model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RootScene extends StatefulWidget {
  @override
  _RootSceneState createState() => _RootSceneState();
}

class _RootSceneState extends State<RootScene> {
  int _tabIndex = 1;
  bool isFinishSetup = false;
  List<Image> _tabImages = [
    Image.asset('img/tab_bookshelf_n.png'),
    Image.asset('img/tab_bookstore_n.png'),
    Image.asset('img/tab_me_n.png'),
  ];
  List<Image> _tabSelectedImages = [
    Image.asset('img/tab_bookshelf_p.png'),
    Image.asset('img/tab_bookstore_p.png'),
    Image.asset('img/tab_me_p.png'),
  ];

  @override
  void initState() {
    super.initState();

    setupApp();
    login();
    wechatRegistered();
    HttpRequest.request('https://httpbin.org/get/s', paras: {'name': 'xu'})
        .then((value) {
      print('请求成功-------$value');
    }).catchError((onError) {
      print('请求失败root-------$onError');
    });
  }

  wechatRegistered() {
    WechatManager.instance;
  }

  setupApp() async {
    // preferences = await SharedPreferences.getInstance();
    // setState(() {
    //   isFinishSetup = true;
    // });
  }

  login() async {
    try {
      Response response = await Dio().post(
        'https://neiwang2.ydcfo.com/CXF/rs/direct/sys/user/token/get',
        data: {
          'username': 'tuopan_byy',
          'password': '123456',
          'deviceType': 'iOS'
        },
      );
      Map result = json.decode(response.toString());
      var user = new UserModel.fromJson(result['data']);
      UserManager.instance.user = user;
      print('token + ${UserManager.instance.user.token}');

      ///响应数据
    } catch (e) {
      print(e.runtimeType);
    }
  }

  @override
  Widget build(BuildContext context) {
    isFinishSetup = true;
    if (!isFinishSetup) {
      return Container();
    }
    return Scaffold(
      body: IndexedStack(
        children: [
          Text('书架'),
          Text('首页'),
          MineScene(),
        ],
        index: _tabIndex,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: SQColor.primary,
        items: [
          BottomNavigationBarItem(
            icon: getTabIcon(0),
            label: '书架',
          ),
          BottomNavigationBarItem(
            icon: getTabIcon(1),
            label: '书城',
          ),
          BottomNavigationBarItem(
            icon: getTabIcon(2),
            label: '我的',
          ),
        ],
        currentIndex: _tabIndex,
        onTap: (value) {
          setState(() {
            _tabIndex = value;
          });
        },
      ),
    );
  }

  Image getTabIcon(int indx) {
    if (indx == _tabIndex) {
      return _tabSelectedImages[indx];
    } else {
      return _tabImages[indx];
    }
  }
}
