import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class TestRequest {
  static const String baseUrl = 'https://neiwangwms.ydcfo.com/';

  static Future<dynamic> get({String action, Map params}) async {
    return TestRequest.mock(action: action, params: params);
  }

  static Future<dynamic> post({String action, Map params}) async {
    return TestRequest.mock(action: action, params: params);
  }

  static Future<dynamic> mock({String action, Map params}) async {
    var responseStr = await rootBundle.loadString('mock/$action.json');
    var responseJson = json.decode(responseStr);
    return responseJson['data'];
  }
}
