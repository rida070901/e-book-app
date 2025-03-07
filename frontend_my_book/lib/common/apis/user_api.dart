 import 'package:my_book/common/entities/entities.dart';
import '../utils/http_util.dart';

class UserAPI {

  static login({LoginRequestEntity? params}) async{
    var response = await HttpUtil().post(
      'api/login',
      queryParameters: params?.toJson()
    );

    //print("response from login method 1 is ${response.toString()}");
    //print("response from login method 2 is ${UserLoginResponseEntity.fromJson(response)}");

    return UserLoginResponseEntity.fromJson(response);

  }
}