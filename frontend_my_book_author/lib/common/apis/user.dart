import 'package:learn_teacher_bloc/common/entities/entities.dart';

import '../utils/http.dart';

class UserAPI {
  static Future<UserLoginResponseEntity> login({
    LoginRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'author/login',
      queryParameters: params?.toJson(),
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  static Future<UserLoginResponseEntity> get_profile() async {
    var response = await HttpUtil().post(
      'author/get_profile',
    );
    return UserLoginResponseEntity.fromJson(response);
  }
  static Future<BaseResponseEntity> UpdateProfile({
    LoginProfileRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'author/update_profile',
      queryParameters: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }


}
