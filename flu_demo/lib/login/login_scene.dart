import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flu_demo/Third/wechat_manager.dart';
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
          'https://neiwangwms.ydcfo.com/wms/xs/payment/order/create?access_token=${UserManager.currentUser.token}',
          data: {
            "createBy": "tuopan_byy",
            "totalAmount": 229351.8,
            "detailVOList": [
              {
                "billingCode": "YZD202012010001",
                "payAmt": 229351.8,
                "channelAmt": 0,
                "payStatus": 0,
                "profitAmt": 693.3,
                "billingId": "629901",
                "profitReceiveAmt": 0
              }
            ],
            "totalProfitAmt": 693.3,
            "frontEnd": "app",
            "ownerId": 48957,
            "tenantId": 48957,
            "payWay": "WECHAT",
            "payType": "APP",
            "enableWriteOff": false,
            "payUserId": 48401,
            "source": "XS",
            "fromPlatform": false,
            "advanceAmount": 0,
            "currency": "RMB",
            "totalChannelAmt": 0,
          });
      Map result = json.decode(response.toString());
      // print('payment/order/create + ${result}\n\n');

      Response response1 = await Dio().put(
        'https://neiwangwms.ydcfo.com/wms/xs/payment/sign?access_token=${UserManager.currentUser.token}',
        data: {
          "payWay": "WECHAT",
          "payType": "APP",
          "frontEnd": "app",
          "tenantId": '48957',
          "xsOwnerId": '48401',
          "sourceBatchNo": result['data']['orderPayNo'],
          "orderPayNo": result['data']['orderPayNo'],
        },
      );
      Map result1 = json.decode(response1.toString());
      print('xs/payment/sign + ${result1['data']['sign']}\n\n');

      WechatManager.instance.pay(
        appId: 'wxd8408f4f68029d35',
        partnerId: '1482666592',
        prepayId: result1['data']['prepay_id'],
        package: 'Sign=WXPay',
        nonceStr: result1['data']['nonceStr'],
        timeStamp: result1['data']['timeStamp'],
        sign: result1['data']['sign'],
      );

      // "payWay" : "WECHAT",
      // "payType" : "APP",
      // "frontEnd" : "app",
      // "tenantId" : 48957,
      // "xsOwnerId" : 48401,
      // "sourceBatchNo" : "YCZD20201215101119333323",
      // "orderPayNo" : "YCZD20201215101119333323"

      // PayReq *req   = [[PayReq alloc] init];
      //   req.partnerId = @"1482666592";
      //   req.package   = @"Sign=WXPay";
      // req.prepayId  = result[@"prepay_id"];
      //   req.sign      = result[@"sign"];
      //   req.timeStamp = [result[@"timeStamp"] intValue];
      //   req.nonceStr  = result[@"nonceStr"];

      ///响应数据
    } catch (e) {}
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
