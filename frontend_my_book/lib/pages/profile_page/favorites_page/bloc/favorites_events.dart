import '../../../../common/entities/book.dart';

abstract class FavoritesEvent {
  const FavoritesEvent();
}

class TriggerInitialFavoritesEvent extends FavoritesEvent{
  const TriggerInitialFavoritesEvent();
}

class TriggerLoadingFavoritesEvent extends FavoritesEvent{
  const TriggerLoadingFavoritesEvent();
}

class TriggerDoneLoadingFavoritesEvent extends FavoritesEvent{
  const TriggerDoneLoadingFavoritesEvent();
}

class TriggerLoadedFavoritesEvent extends FavoritesEvent{
  const TriggerLoadedFavoritesEvent(this.bookItem);
  final List<BookItem> bookItem;
}