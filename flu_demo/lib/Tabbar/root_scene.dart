import 'package:flu_demo/BaseDefine/sq_color.dart';
import 'package:flu_demo/Mine/me_scene.dart';
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
  }

  setupApp() async {
    // preferences = await SharedPreferences.getInstance();
    // setState(() {
    //   isFinishSetup = true;
    // });
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
