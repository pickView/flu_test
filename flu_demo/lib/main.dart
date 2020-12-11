// import 'package:flu_demo/Tabbar/app_scene.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(AppScene());
// }

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as image;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:wechat_kit/wechat_kit.dart';

void main() => runApp(MyApp());

const String WECHAT_APPID = 'wxd8408f4f68029d35';
const String WECHAT_UNIVERSAL_LINK = 'https://iosupdate.ydcfo.com/'; // iOS 请配置
const String WECHAT_APPSECRET = '6f65427b7f584ae284331d92ce2c037e';
const String WECHAT_MINIAPPID = 'your wechat miniAppId';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  createPayOrder() async {
    //https://neiwangwms.ydcfo.com/xs/payment/order/create'
    // {
    //           "createBy": "tuopan_byy",
    //           "totalAmount": 229351.8,
    //           "detailVOList": [
    //             {
    //               "billingCode": "YZD202012010001",
    //               "payAmt": 229351.8,
    //               "channelAmt": 0,
    //               "payStatus": 0,
    //               "profitAmt": 693.3,
    //               "billingId": "629901",
    //               "profitReceiveAmt": 0
    //             }
    //           ],
    //           "totalProfitAmt": 693.3,
    //           "frontEnd": "app",
    //           "ownerId": 48957,
    //           "tenantId": 48957,
    //           "payWay": "WECHAT",
    //           "payType": "APP",
    //           "enableWriteOff": false,
    //           "payUserId": 48401,
    //           "source": "XS",
    //           "fromPlatform": false,
    //           "advanceAmount": 0,
    //           "currency": "RMB",
    //           "totalChannelAmt": 0
    //         }
    Dio dio = Dio();
    Response response = await dio
        .post('https://neiwangwms.ydcfo.com/xs/payment/order/create', data: {
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
      "totalChannelAmt": 0
    });
    // print(response);
  }

  Wechat _wechat = Wechat()
    ..registerApp(
      appId: WECHAT_APPID,
      universalLink: WECHAT_UNIVERSAL_LINK,
    );

  StreamSubscription<WechatAuthResp> _auth;
  StreamSubscription<WechatSdkResp> _share;
  StreamSubscription<WechatPayResp> _pay;
  StreamSubscription<WechatLaunchMiniProgramResp> _miniProgram;

  WechatAuthResp _authResp;

  @override
  void initState() {
    super.initState();
    _auth = _wechat.authResp().listen(_listenAuth);
    _share = _wechat.shareMsgResp().listen(_listenShareMsg);
    _pay = _wechat.payResp().listen(_listenPay);
    _miniProgram = _wechat.launchMiniProgramResp().listen(_listenMiniProgram);
  }

  void _listenAuth(WechatAuthResp resp) {
    _authResp = resp;
    String content = 'auth: ${resp.errorCode} ${resp.errorMsg}';
    _showTips('登录', content);
  }

  void _listenShareMsg(WechatSdkResp resp) {
    String content = 'share: ${resp.errorCode} ${resp.errorMsg}';
    _showTips('分享', content);
  }

  void _listenPay(WechatPayResp resp) {
    String content = 'pay: ${resp.errorCode} ${resp.errorMsg}';
    _showTips('支付', content);
  }

  void _listenMiniProgram(WechatLaunchMiniProgramResp resp) {
    String content = 'mini program: ${resp.errorCode} ${resp.errorMsg}';
    _showTips('拉起小程序', content);
  }

  @override
  void dispose() {
    _auth?.cancel();
    _auth = null;
    _share?.cancel();
    _share = null;
    _pay?.cancel();
    _pay = null;
    _miniProgram?.cancel();
    _miniProgram = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wechat Kit Demo'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('支付'),
            onTap: () {
              // 微信 Demo 例子：https://wxpay.wxutil.com/pub_v2/app/app_pay.php
              print('点击了支付');
              createPayOrder();
              // _wechat.pay(
              //   appId: WECHAT_APPID,
              //   partnerId: '1482666592',
              //   prepayId: '预支付交易会话ID',
              //   package: 'Sign=WXPay',
              //   nonceStr: '随机字符串, 随机字符串，不长于32位',
              //   timeStamp: '时间戳：东八区，单位秒',
              //   sign: '签名',
              // );
            },
          ),
        ],
      ),
    );
  }

  void _showTips(String title, String content) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
        );
      },
    );
  }
}

class Qrauth extends StatefulWidget {
  const Qrauth({
    Key key,
    this.wechat,
  }) : super(key: key);

  final Wechat wechat;

  @override
  State<StatefulWidget> createState() {
    return _QrauthState();
  }
}

class _QrauthState extends State<Qrauth> {
  StreamSubscription<Uint8List> _authGotQrcode;
  StreamSubscription<String> _authQrcodeScanned;
  StreamSubscription<WechatQrauthResp> _authFinish;

  Uint8List _qrcod;

  @override
  void initState() {
    super.initState();
    _authGotQrcode =
        widget.wechat.authGotQrcodeResp().listen(_listenAuthGotQrcode);
    _authQrcodeScanned =
        widget.wechat.authQrcodeScannedResp().listen(_listenAuthQrcodeScanned);
    _authFinish = widget.wechat.authFinishResp().listen(_listenAuthFinish);
  }

  void _listenAuthGotQrcode(Uint8List qrcode) {
    _qrcod = qrcode;
    setState(() {});
  }

  void _listenAuthQrcodeScanned(String msg) {
    print('msg: $msg');
  }

  void _listenAuthFinish(WechatQrauthResp qrauthResp) {
    print('resp: ${qrauthResp.errorCode} - ${qrauthResp.authCode}');
  }

  @override
  void dispose() {
    _authGotQrcode?.cancel();
    _authGotQrcode = null;
    _authQrcodeScanned?.cancel();
    _authQrcodeScanned = null;
    _authFinish?.cancel();
    _authFinish = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qrauth'),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              WechatAccessTokenResp accessToken =
                  await widget.wechat.getAccessToken(
                appId: WECHAT_APPID,
                appSecret: WECHAT_APPSECRET,
              );
              print(
                  'accessToken: ${accessToken.errcode} - ${accessToken.errmsg} - ${accessToken.accessToken}');
              WechatTicketResp ticket = await widget.wechat.getTicket(
                accessToken: accessToken.accessToken,
              );
              print(
                  'accessToken: ${ticket.errcode} - ${ticket.errmsg} - ${ticket.ticket}');
              await widget.wechat.startQrauth(
                appId: WECHAT_APPID,
                scope: <String>[WechatScope.SNSAPI_USERINFO],
                ticket: ticket.ticket,
              );
            },
            child: const Text('got qr code'),
          ),
        ],
      ),
      body: GestureDetector(
        child: Center(
          child:
              _qrcod != null ? Image.memory(_qrcod) : const Text('got qr code'),
        ),
      ),
    );
  }
}
