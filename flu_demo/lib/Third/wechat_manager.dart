import 'package:wechat_kit/wechat_kit.dart';

const String WECHAT_APPID = 'wxd8408f4f68029d35';
const String WECHAT_UNIVERSAL_LINK = 'https://iosupdate.ydcfo.com/'; // iOS 请配置
const String WECHAT_APPSECRET = '6f65427b7f584ae284331d92ce2c037e';

class WechatManager extends Wechat {
  static WechatManager _instance;

  static WechatManager get instance {
    if (_instance == null) {
      _instance = WechatManager();
      _instance.registerApp(
        appId: WECHAT_APPID,
        universalLink: WECHAT_UNIVERSAL_LINK,
      );
    }
    return _instance;
  }
}
