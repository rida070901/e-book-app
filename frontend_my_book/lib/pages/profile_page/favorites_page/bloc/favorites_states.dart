import '../../../../common/entities/book.dart';

abstract class FavoritesState {
  const FavoritesState();
}
class InitialFavoritesState extends FavoritesState{
  const InitialFavoritesState();
}

class LoadingFavoritesState extends FavoritesState{
  const LoadingFavoritesState();
}

class DoneLoadingFavoritesState extends FavoritesState{
  const DoneLoadingFavoritesState();
}

class LoadedFavoritesState extends FavoritesState{
  const LoadedFavoritesState(this.bookItem);
  final List<BookItem> bookItem;
}