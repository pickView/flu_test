import 'package:flu_demo/Mine/me_cell.dart';
import 'package:flu_demo/Mine/me_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MineScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
          child: Container(
            color: Colors.white,
            child: ListView(
              children: [
                SizedBox(height: 10),
                buildCells(context),
              ],
            ),
          ),
          value: SystemUiOverlayStyle.dark),
    );
  }

  Widget buildCells(BuildContext context) {
    return Container(
      child: Column(
        children: [
          MineCell(
            title: '钱包',
            iconName: 'img/me_wallet.png',
            onPressed: () {},
          ),
          MineCell(
            title: '消费充值记录',
            iconName: 'img/me_record.png',
            onPressed: () {},
          ),
          MineCell(
            title: '购买的书',
            iconName: 'img/me_buy.png',
            onPressed: () {},
          ),
          MineCell(
            title: '我的会员',
            iconName: 'img/me_vip.png',
            onPressed: () {},
          ),
          MineCell(
            title: '绑兑换码',
            iconName: 'img/me_coupon.png',
            onPressed: () {},
          ),
          MineCell(
            title: '阅读之约',
            iconName: 'img/me_date.png',
            onPressed: () {},
          ),
          MineCell(
            title: '公益行动',
            iconName: 'img/me_action.png',
            onPressed: () {},
          ),
          MineCell(
            title: '我的收藏',
            iconName: 'img/me_favorite.png',
            onPressed: () {},
          ),
          MineCell(
            title: '打赏记录',
            iconName: 'img/me_record.png',
            onPressed: () {},
          ),
          MineCell(
            title: '我的书评',
            iconName: 'img/me_comment.png',
            onPressed: () {},
          ),
          MineCell(
            title: '个性换肤',
            iconName: 'img/me_theme.png',
            onPressed: () {},
          ),
          MineCell(
            title: '设置',
            iconName: 'img/me_setting.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SettingScene();
              }));
            },
          ),
        ],
      ),
    );
  }
}
