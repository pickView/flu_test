import 'dart:ffi';

import 'package:flu_demo/BaseDefine/sq_color.dart';
import 'package:flu_demo/Mine/me_scene.dart';
import 'package:flutter/material.dart';

class MineHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MineScene();
        }));
      },
      child: Container(
        color: SQColor.white,
        padding: EdgeInsets.fromLTRB(20, 30, 15, 15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('img/placeholder_avatar.png'),
            ),
            SizedBox(
              width: 25,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '登录',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildItems(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //buildItem
      ],
    );
  }

  Widget buildItem(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: SQColor.gray),
        ),
      ],
    );
  }
}
