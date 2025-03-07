import 'package:my_book/common/entities/base.dart';
import '../entities/book.dart';
import '../utils/http_util.dart';

class BookAPI {

  static Future<BookListResponseEntity> bookList() async {
    var response = await HttpUtil().post(
        'api/bookList'
    );
    //print("response from book api 1 is ${response.toString()}");
    return BookListResponseEntity.fromJson(response);
  }

  static Future<BookListResponseEntity> recommendedBookList() async {
    var response = await HttpUtil().post(
        'api/recommendedBookList'
    );
    //print("response from book api 1 is ${response.toString()}");
    return BookListResponseEntity.fromJson(response);
  }

  static Future<BookListResponseEntity> newBookList() async {
    var response = await HttpUtil().post(
        'api/newBooksList'
    );
    //print("response from book api 1 is ${response.toString()}");
    return BookListResponseEntity.fromJson(response);
  }

  static Future<BookListResponseEntity> fromCheapestList() async {
    var response = await HttpUtil().post(
        'api/fromCheapestList'
    );
    //print("response from book api 1 is ${response.toString()}");
    return BookListResponseEntity.fromJson(response);
  }

  static Future<BookListResponseEntity> searchBook({SearchRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/searchBookList',
      queryParameters: params?.toJson(),
    );
    //print("response from book api 2 is ${response.toString()}");
    return BookListResponseEntity.fromJson(response);
  }

  static Future<BookDetailResponseEntity> bookDetails({BookRequestEntity? params}) async {
    var response = await HttpUtil().post(
        'api/bookDetail',
         queryParameters: params?.toJson(),
    );
    return BookDetailResponseEntity.fromJson(response);
  }

  static Future<TrailerDetailResponseEntity> trailerDetail({BookRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/trailerDetail',
      queryParameters: params?.toJson(),
    );
    //print("response from book api 2 is ${response.toString()}");
    return TrailerDetailResponseEntity.fromJson(response);
  }

  static Future<BookListResponseEntity> booksBought() async {
    var response = await HttpUtil().post(
        'api/booksBought'
    );
    //print("response from book api 1 is ${response.toString()}");
    return BookListResponseEntity.fromJson(response);
  }

  static Future<BookListResponseEntity> favoritesList() async {
    var response = await HttpUtil().post(
        'api/favoritesList'
    );
    //print("response from book api 1 is ${response.toString()}");
    return BookListResponseEntity.fromJson(response);
  }

  static Future<FavoritesResponseEntity> addFavorite({BookRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/addFavorite',
      queryParameters: params?.toJson(),
    );
    return FavoritesResponseEntity.fromJson(response);
  }

  static Future<FavoritesResponseEntity> updateFavorite({BookRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/updateFavorite',
      queryParameters: params?.toJson(),
    );
    return FavoritesResponseEntity.fromJson(response);
  }

  static Future<FavoritesResponseEntity> checkFavorite({BookRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/checkFavorite',
      queryParameters: params?.toJson(),
    );
    return FavoritesResponseEntity.fromJson(response);
  }

  static Future<BookListResponseEntity> orderList() async {
    var response = await HttpUtil().post(
        'api/orderList'
    );
    //print("response from book api 1 is ${response.toString()}");
    return BookListResponseEntity.fromJson(response);
  }

  //pay book
  static Future<BaseResponseEntity> bookPay({BookRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/checkout',
      queryParameters: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

// to check if book is bought by user
  static Future<BaseResponseEntity> bookBought({BookRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/bookBought',
      queryParameters: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }

  //author profile page
  static Future<AuthorResponseEntity> bookAuthor(AuthorRequestEntity? params) async {
    var response = await HttpUtil().post(
        'api/bookAuthor',
      queryParameters: params?.toJson(),
    );
    //print("response from book api 1 is ${response.toString()}");
    return AuthorResponseEntity.fromJson(response);
  }

  //authors list of books
  static Future<BookListResponseEntity> bookListAuthor(AuthorRequestEntity? params) async {
    var response = await HttpUtil().post(
      'api/bookListAuthor',
      queryParameters: params?.toJson(),
    );
    //print("response from book api 1 is ${response.toString()}");
    return BookListResponseEntity.fromJson(response);
  }

}