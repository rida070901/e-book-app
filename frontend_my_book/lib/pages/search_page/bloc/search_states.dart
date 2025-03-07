import '../../../common/entities/book.dart';

class SearchState {
  const SearchState({
    this.bookItem = const <BookItem>[]
  });

  final List<BookItem> bookItem;

  SearchState copyWith({List<BookItem>? bookItem}){
    return SearchState(bookItem: bookItem??this.bookItem);
  }

}