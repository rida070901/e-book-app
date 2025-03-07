import '../../../../common/entities/book.dart';

class AuthorProfileStates {
  final AuthorItem? authorItem;
  final List<BookItem> bookItem;

  const AuthorProfileStates(
      {this.authorItem, this.bookItem = const <BookItem>[]});

  AuthorProfileStates copyWith(
      {AuthorItem? authorItem, List<BookItem>? bookItem}) {
    return AuthorProfileStates(
        authorItem: authorItem ?? this.authorItem,
        bookItem: bookItem ?? this.bookItem);
  }
}
