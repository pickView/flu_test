import 'package:dio/dio.dart';

class HttpRequest {
  var config = HttpConfig();

  static final BaseOptions baseOptions = BaseOptions(
    baseUrl: HttpConfig.baseUrl,
    connectTimeout: HttpConfig.timeOut,
  );
  static final Dio dio = Dio();
  static Future<T> request<T>(
    String url, {
    String method = 'get',
    Map<String, dynamic> paras,
    Interceptor curretInter,
  }) async {
    final options = Options(method: method);
    Interceptor inter = InterceptorsWrapper(
      onRequest: (options) {
        return options;
      },
      onResponse: (options) {
        return options;
      },
      onError: (err) {
        print('请求失败-------拦截器');

        //return err;
      },
    );
    List<Interceptor> inters = [inter];
    if (curretInter != null) {
      inters.add(curretInter);
    }
    dio.interceptors.addAll(inters);
    // try {
    Response response = await dio.request(
      url,
      queryParameters: paras,
      options: options,
    );
    return response.data;
    // } on DioError catch (e) {
    //   print('请求失败-------基类');
    //   return Future.error(e);
    // }
  }
}

class HttpConfig {
  static const String baseUrl = 'https://httbin.org';
  static const int timeOut = 5000;
  var sss = '1';
}
