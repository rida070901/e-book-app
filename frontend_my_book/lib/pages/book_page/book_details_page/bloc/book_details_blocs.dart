import 'package:flutter_bloc/flutter_bloc.dart';
import 'book_details_events.dart';
import 'book_details_states.dart';

class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {
  BookDetailsBloc() :super(const BookDetailsState()) {
    on<TriggerBookDetailsEvent>(_triggerBookDetailsEvent);
    on<TriggerChapterListEvent>(_triggerChapterListEvent);
    on<TriggerCheckBuy>(_triggerCheckBuy);
    on<UpdateFavoriteStatus>(_updateFavoriteStatus);
  }

  _triggerBookDetailsEvent(TriggerBookDetailsEvent event,
      Emitter<BookDetailsState> emit) {
    emit(state.copyWith(bookItem: event.bookItem));
  }

  _triggerChapterListEvent(TriggerChapterListEvent event,
      Emitter<BookDetailsState> emit) {
    emit(state.copyWith(chapterListItem: event.chapterListItem));
  }

  _triggerCheckBuy(TriggerCheckBuy event,
      Emitter<BookDetailsState> emit) {
    emit(state.copyWith(checkBuy: event.checkBuy));
  }

  _updateFavoriteStatus(UpdateFavoriteStatus event,
      Emitter<BookDetailsState> emit) {
    emit(state.copyWith(favoriteStatus: event.favoriteStatus));
  }
}