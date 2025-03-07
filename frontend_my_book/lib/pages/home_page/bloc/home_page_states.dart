import 'package:my_book/common/entities/book.dart';

class HomePageState {
  const HomePageState({
    this.bookItem = const <BookItem>[],
    this.index=0,
    this.bookListIndex=0,
  });

  final int index;
  final List<BookItem> bookItem;
  final int bookListIndex;

  HomePageState copyWith({int? index, List<BookItem>? bookItem, int? bookListIndex}){
    return HomePageState(
        bookItem: bookItem??this.bookItem,
        index: index??this.index,
        bookListIndex: bookListIndex??this.bookListIndex,
    );
  }
}