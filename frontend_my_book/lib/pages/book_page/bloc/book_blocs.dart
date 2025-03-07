import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/pages/book_page/bloc/book_events.dart';
import 'package:my_book/pages/book_page/bloc/book_states.dart';

class BookBloc extends Bloc<BookEvent, BookState>{
  BookBloc():super(const BookState()){
    on<TriggerBookEvent>(_triggerBookEvent);
  }

  _triggerBookEvent(TriggerBookEvent event, Emitter<BookState> emit){
    emit(state.copyWith(bookItem: event.bookItem));
  }
}