import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/pages/search_page/bloc/search_events.dart';
import 'package:my_book/pages/search_page/bloc/search_states.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<TriggerSearchEvent>(_triggerSearchEvent);
  }

  _triggerSearchEvent(TriggerSearchEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(bookItem: event.bookItem));
  }
}
