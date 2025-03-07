import 'package:my_book/common/entities/book.dart';
import '../../../../common/entities/chapter.dart';

abstract class BookDetailsEvent{
  const BookDetailsEvent();
}

class TriggerBookDetailsEvent extends BookDetailsEvent{
  const TriggerBookDetailsEvent(this.bookItem):super();
  final BookItem bookItem;
}

class TriggerChapterListEvent extends BookDetailsEvent{
  const TriggerChapterListEvent(this.chapterListItem):super();
  final List<ChapterListItem> chapterListItem;
}

class TriggerCheckBuy extends BookDetailsEvent{
  const TriggerCheckBuy(this.checkBuy):super();
  final bool checkBuy;
}

class UpdateFavoriteStatus extends BookDetailsEvent{
  const UpdateFavoriteStatus(this.favoriteStatus);
  final int? favoriteStatus;
}

