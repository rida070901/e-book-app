import 'package:my_book/common/entities/book.dart';

abstract class BookEvent{
  const BookEvent();
}

class TriggerBookEvent extends BookEvent{
  const TriggerBookEvent(this.bookItem):super();
  final BookItem bookItem;
}

