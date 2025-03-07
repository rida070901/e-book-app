import 'package:my_book/common/entities/book.dart';
import '../../../../common/entities/chapter.dart';

class BookDetailsState{
  const BookDetailsState({this.bookItem, this.chapterListItem = const <ChapterListItem> [],
    this.checkBuy=false, this.favoriteStatus});

  final BookItem? bookItem;
  final List<ChapterListItem> chapterListItem;
  final bool? checkBuy;
  final int? favoriteStatus;

  BookDetailsState copyWith({BookItem? bookItem, List<ChapterListItem>? chapterListItem,
    bool? checkBuy, int? favoriteStatus}){
    return BookDetailsState(
        bookItem: bookItem ?? this.bookItem,
        chapterListItem: chapterListItem ?? this.chapterListItem,
        checkBuy: checkBuy ?? this.checkBuy,
        favoriteStatus: favoriteStatus ?? this.favoriteStatus
    );
  }
}