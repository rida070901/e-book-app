import '../../../common/entities/book.dart';

abstract class SearchEvent{}

class TriggerSearchEvent extends SearchEvent{
  TriggerSearchEvent(this.bookItem);
  final List<BookItem> bookItem;
}