
class ChapterRequestEntity {
  int? id;

  ChapterRequestEntity({
    this.id,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}


class ChapterListResponseEntity {
  int? code;
  String? msg;
  List<ChapterListItem>? data;

  ChapterListResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory ChapterListResponseEntity.fromJson(Map<String, dynamic> json) =>
      ChapterListResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<ChapterListItem>.from(json["data"].map((x) => ChapterListItem.fromJson(x))),
      );
}



class ChapterDetailResponseEntity {
  int? code;
  String? msg;
  ChapterDetailItem? data;

  ChapterDetailResponseEntity({
    this.code,
    this.msg,
    this.data,
  });


  factory ChapterDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      ChapterDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: ChapterDetailItem.fromJson(json["data"]),
      );
}



class ChapterListItem {
  String? name;
  String? title;
  String? subtitle;
  String? text;
  int? id;

  ChapterListItem({
    this.name,
    this.title,
    this.subtitle,
    this.text,
    this.id,
  });

  factory ChapterListItem.fromJson(Map<String, dynamic> json) =>
      ChapterListItem(
        name: json["name"],
        title: json["title"],
        subtitle: json["subtitle"],
        text: json["text"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "title": title,
    "subtitle": subtitle,
    "text": text,
    "id": id,
  };
}



class ChapterDetailItem {
  String? name;
  String? title;
  String? subtitle;
  String? text;
  int? id;

  ChapterDetailItem({
    this.name,
    this.title,
    this.subtitle,
    this.text,
    this.id,
  });

  factory ChapterDetailItem.fromJson(Map<String, dynamic> json) =>
      ChapterDetailItem(
        name: json["name"],
        title: json["title"],
        subtitle: json["subtitle"],
        text: json["text"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "title": title,
    "subtitle": subtitle,
    "text": text,
    "id": id,
  };
}