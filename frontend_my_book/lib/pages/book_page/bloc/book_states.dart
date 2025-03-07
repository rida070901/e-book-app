import 'package:my_book/common/entities/book.dart';

class BookState{
  const BookState({this.bookItem});

  final BookItem? bookItem;

  BookState copyWith({BookItem? bookItem}){
    return BookState(
      bookItem: bookItem ?? this.bookItem,
    );
  }
}