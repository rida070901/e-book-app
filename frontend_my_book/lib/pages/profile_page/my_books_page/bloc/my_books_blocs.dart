import 'package:flutter_bloc/flutter_bloc.dart';
import 'my_books_events.dart';
import 'my_books_states.dart';

class MyBooksBloc extends Bloc<MyBooksEvent, MyBooksState>{
  MyBooksBloc():super(const InitialMyBooksState()){
    on<TriggerInitialMyBooksEvent>(_triggerInitialMyBooksEvent);
    on<TriggerLoadingMyBooksEvent>(_triggerLoadingMyBooks);
    on<TriggerLoadedMyBooksEvent>(_triggerLoadedMyBooks);
    on<TriggerDoneLoadingMyBooksEvent>(_triggerDoneLoadingMyBooks);
  }
  _triggerInitialMyBooksEvent(TriggerInitialMyBooksEvent event, Emitter<MyBooksState> emit){
    print('initial.....');
    emit(InitialMyBooksState());
  }

  _triggerLoadedMyBooks(TriggerLoadedMyBooksEvent event, Emitter<MyBooksState> emit){
    print('loaded.....');

    emit(LoadedMyBooksState(event.bookItem));

  }

  _triggerLoadingMyBooks(TriggerLoadingMyBooksEvent event, Emitter<MyBooksState> emit){
    //we are calling state classes directly. State classes are similar to state properties,
    //we have seen with state.copyWith() method previously
    print('loading....');
    emit( const LoadingMyBooksState());
  }

  _triggerDoneLoadingMyBooks(TriggerDoneLoadingMyBooksEvent event, Emitter<MyBooksState> emit){
    //we are calling state classes directly. State classes are similar to state properties,
    //we have seen with state.copyWith() method previously
    print('done....');
    emit( const DoneLoadingMyBooksState());

  }
}