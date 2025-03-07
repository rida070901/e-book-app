import 'package:my_book/common/entities/chapter.dart';
import '../utils/http_util.dart';

class ChapterAPI {

  static Future<ChapterListResponseEntity> chapterList({ChapterRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/chapterList',
      queryParameters: params?.toJson(),
    );
    //print("response from edition api 1 is ${response.toString()}");
    return ChapterListResponseEntity.fromJson(response);
  }

  static Future<ChapterDetailResponseEntity> chapterDetails({ChapterRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/chapterDetail',
      queryParameters: params?.toJson(),
    );
    //print("response from edition api 2 is ${response.toString()}");
    return ChapterDetailResponseEntity.fromJson(response);
  }

}