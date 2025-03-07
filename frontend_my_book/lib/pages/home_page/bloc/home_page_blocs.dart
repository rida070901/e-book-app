import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page_events.dart';
import 'home_page_states.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState>{
  HomePageBloc():super(const HomePageState()){
    on<HomePageDots>(_homePageDots);
    on<HomePageBookItem>(_homePageBookItem);
    on<BookListIndex>(_bookListIndex);
  }

  void _homePageDots(HomePageDots event, Emitter<HomePageState> emit){
    emit(state.copyWith(index: event.index));
  }

  void _homePageBookItem(HomePageBookItem event, Emitter<HomePageState> emit){
    emit(state.copyWith(bookItem: event.bookItem));
  }

  void _bookListIndex(BookListIndex event, Emitter<HomePageState> emit){
    emit(state.copyWith(bookListIndex: event.bookListIndex));
  }
}