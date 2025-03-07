import '../../../../common/entities/book.dart';

abstract class MyBooksState {
  const MyBooksState();
}
class InitialMyBooksState extends MyBooksState{
  const InitialMyBooksState();
}
class LoadingMyBooksState extends MyBooksState{
  const LoadingMyBooksState();
}

class DoneLoadingMyBooksState extends MyBooksState{
  const DoneLoadingMyBooksState();
}
class LoadedMyBooksState extends MyBooksState{
  const LoadedMyBooksState(this.bookItem);
  final List<BookItem> bookItem;
}
