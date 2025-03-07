import '../../../common/entities/book.dart';

abstract class HomePageEvent {
  const HomePageEvent();
}

class HomePageDots extends HomePageEvent{
  final int index;
  const HomePageDots(this.index):super();
}

class HomePageBookItem extends HomePageEvent{
  const HomePageBookItem(this.bookItem);
  final List<BookItem> bookItem;
}

class BookListIndex extends HomePageEvent{
  final int bookListIndex;
  const BookListIndex(this.bookListIndex):super();
}