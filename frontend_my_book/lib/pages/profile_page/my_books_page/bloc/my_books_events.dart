import '../../../../common/entities/book.dart';

abstract class MyBooksEvent{
  const MyBooksEvent();
}

class TriggerInitialMyBooksEvent extends MyBooksEvent{
  const TriggerInitialMyBooksEvent();
}
class TriggerLoadingMyBooksEvent extends MyBooksEvent{
  const TriggerLoadingMyBooksEvent();
}

class TriggerDoneLoadingMyBooksEvent extends MyBooksEvent{
  const TriggerDoneLoadingMyBooksEvent();
}

class TriggerLoadedMyBooksEvent extends MyBooksEvent{
  const TriggerLoadedMyBooksEvent(this.bookItem);
  final List<BookItem> bookItem;
}