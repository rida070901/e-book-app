import 'package:dio/dio.dart';
import 'package:my_book/global.dart';
import '../values/constants.dart';

class HttpUtil {
  //singleton class
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil(){
    return _instance;
  }

  late Dio dio;

  HttpUtil._internal(){
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.SERVER_API_URL,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {},
      contentType: "application/json: charset=utf-8",
      responseType: ResponseType.json,
    );
    dio = Dio(options);
  }

  Future post(String path,
      {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if(authorization != null){
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.post(
        path, data: data, queryParameters: queryParameters, options: requestOptions);
    //print("my response from post from http_util class is ${response.toString()}");
    //print("and my status code is ${response.statusCode}");
    return response.data;
  }

  Map<String, dynamic>? getAuthorizationHeader() { //retrieve the access token
    var headers = <String, dynamic>{};
    var accessToken = Global.storageService.getUserToken();
    if(accessToken.isNotEmpty){
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

}