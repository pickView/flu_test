import 'package:flu_demo/BaseDefine/sq_color.dart';
import 'package:flutter/material.dart';

class MineCell extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconName;
  final String title;

  MineCell({this.title, this.iconName, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              color: SQColor.white,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.asset(iconName),
                  SizedBox(
                    width: 20,
                  ),
                  Text(title, style: TextStyle(fontSize: 18)),
                  Expanded(child: Container()),
                  Image.asset('img/arrow_right.png'),
                ],
              ),
            ),
            Container(
              height: 1,
              color: SQColor.lightGray,
              margin: EdgeInsets.only(left: 60),
            ),
          ],
        ),
      ),
    );
  }
}
