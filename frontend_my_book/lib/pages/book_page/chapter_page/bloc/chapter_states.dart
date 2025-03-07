import 'package:my_book/common/entities/chapter.dart';

class ChapterState{
  const ChapterState({this.chapterDetailItem, this.chapterListItem = const <ChapterListItem> []});

  final ChapterDetailItem? chapterDetailItem;
  final List<ChapterListItem> chapterListItem;


  ChapterState copyWith({ChapterDetailItem? chapterDetailItem, List<ChapterListItem>? chapterListItem}){
    return ChapterState(
      chapterDetailItem: chapterDetailItem ?? this.chapterDetailItem,
      chapterListItem: chapterListItem ?? this.chapterListItem,
    );
  }
}