import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookRequestEntity {
  int? id;

  BookRequestEntity({
    this.id,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class SearchRequestEntity {
  String? search;

  SearchRequestEntity({
    this.search,
  });

  Map<String, dynamic> toJson() => {
        "search": search,
      };
}

//api post response msg
class BookListResponseEntity {
  int? code;
  String? msg;
  List<BookItem>? data;

  BookListResponseEntity({
    this.code,
    this.msg,
    this.data,
  });
  //json['data'] has maps internally. so we need to go through fromJson method
  factory BookListResponseEntity.fromJson(Map<String, dynamic> json) =>
      BookListResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<BookItem>.from(
                json["data"].map((x) => BookItem.fromJson(x))),
      );
}

//api post response msg
class BookDetailResponseEntity {
  int? code;
  String? msg;
  BookItem? data;

  BookDetailResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory BookDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      BookDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: BookItem.fromJson(json["data"]),
      );
}

class AuthorRequestEntity {
  String? token;

  AuthorRequestEntity({
    this.token,
  });

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}

//api post response msg
class AuthorResponseEntity {
  int? code;
  String? msg;
  AuthorItem? data;

  AuthorResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory AuthorResponseEntity.fromJson(Map<String, dynamic> json) =>
      AuthorResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: AuthorItem.fromJson(json["data"]),
      );
}

// login result
class AuthorItem {
  String? token;
  String? name;
  String? description;
  String? avatar;
  String? bg_image;
  String? job;
  int? follow;
  int? score;
  int? download;
  int? online;

  AuthorItem({
    this.token,
    this.name,
    this.description,
    this.avatar,
    this.bg_image,
    this.job,
    this.follow,
    this.score,
    this.download,
    this.online,
  });

  factory AuthorItem.fromJson(Map<String, dynamic> json) => AuthorItem(
        token: json["token"],
        name: json["name"],
        description: json["description"],
        avatar: json["avatar"],
        bg_image: json["bg_image"],
        job: json["job"],
        follow: json["follow"],
        score: json["score"],
        download: json["download"],
        online: json["online"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "description": description,
        "avatar": avatar,
        "bg_image": bg_image,
        "job": job,
        "follow": follow,
        "score": score,
        "download": download,
        "online": online,
      };
}

class BookItem {
  String? user_token;
  String? name;
  String? description;
  String? thumbnail;
  int? price;
  String? amount_total;
  int? page_num;
  String? language;
  String? first_published_date;
  String? title;
  String? author_name;
  int? id;
  int? status;

  BookItem({
    this.user_token,
    this.name,
    this.description,
    this.thumbnail,
    this.price,
    this.amount_total,
    this.page_num,
    this.language,
    this.first_published_date,
    this.title,
    this.author_name,
    this.id,
    this.status,
  });

  factory BookItem.fromJson(Map<String, dynamic> json) => BookItem(
        user_token: json["user_token"],
        name: json["name"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        price: json["price"],
        amount_total: json["amount_total"],
        page_num: json["page_num"],
        language: json["language"],
        first_published_date: json["first_published_date"].toString(),
        title: json["title"],
        author_name: json["author_name"],
        id: json["id"],
        status:json['status']??0
      );

  Map<String, dynamic> toJson() => {
        "user_token": user_token,
        "name": name,
        "description": description,
        "thumbnail": thumbnail,
        "price": price,
        "amount_total": amount_total,
        "page_num": page_num,
        "language": language,
        "first_published_date": first_published_date,
        "title": title,
        "author_name": author_name,
        "id": id,
      };
}


class TrailerDetailResponseEntity {
  int? code;
  String? msg;
  List<TrailerMediaItem>? data;

  TrailerDetailResponseEntity({
    this.code,
    this.msg,
    this.data,
  });


  factory TrailerDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      TrailerDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<TrailerMediaItem>.from(json["data"].map((x) => TrailerMediaItem.fromJson(x))),
      );
}

class TrailerMediaItem {
  String? name;
  String? url;
  String? thumbnail;

  TrailerMediaItem({
    this.name,
    this.url,
    this.thumbnail,
  });

  factory TrailerMediaItem.fromJson(Map<String, dynamic> json) =>
      TrailerMediaItem(
        name: json["name"],
        url: json["url"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
    "thumbnail": thumbnail,
  };
}

//for favorites
class FavoritesResponseEntity {
  int? code;
  String? msg;
  int? data;

  FavoritesResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory FavoritesResponseEntity.fromJson(Map<String, dynamic> json) =>
      FavoritesResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data,
  };
}