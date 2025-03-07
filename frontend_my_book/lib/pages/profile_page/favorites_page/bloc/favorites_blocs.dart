import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/entities/book.dart';
import 'favorites_events.dart';
import 'favorites_states.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState>{
  FavoritesBloc():super(const InitialFavoritesState()){
    on<TriggerInitialFavoritesEvent>(_triggerInitialFavoritesEvent);
    on<TriggerLoadingFavoritesEvent>(_triggerLoadingFavorites);
    on<TriggerLoadedFavoritesEvent>(_triggerLoadedFavorites);
    on<TriggerDoneLoadingFavoritesEvent>(_triggerDoneLoadingFavorites);
  }
  _triggerInitialFavoritesEvent(TriggerInitialFavoritesEvent event, Emitter<FavoritesState> emit){
    print('initial.....');
    emit(const InitialFavoritesState());
  }

  _triggerLoadedFavorites(TriggerLoadedFavoritesEvent event, Emitter<FavoritesState> emit){
    print('loaded.....');
    emit(LoadedFavoritesState(event.bookItem));
  }

  _triggerLoadingFavorites(TriggerLoadingFavoritesEvent event, Emitter<FavoritesState> emit){
    //we are calling state classes directly. State classes are similar to state properties,
    //we have seen with state.copyWith() method previously
    print('loading....');
    emit( const LoadingFavoritesState());
  }

  _triggerDoneLoadingFavorites(TriggerDoneLoadingFavoritesEvent event, Emitter<FavoritesState> emit){
    //we are calling state classes directly. State classes are similar to state properties,
    //we have seen with state.copyWith() method previously
    print('done....');
    emit( const DoneLoadingFavoritesState());
  }
}