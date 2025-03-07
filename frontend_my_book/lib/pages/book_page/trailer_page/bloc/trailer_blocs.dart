import 'package:flutter_bloc/flutter_bloc.dart';

import 'trailer_events.dart';
import 'trailer_states.dart';

class TrailerBloc extends Bloc<TrailerEvent, TrailerState>{
  TrailerBloc():super(const TrailerState()){
    on<TriggerTrailerMedia>(_triggerTrailerMedia);
    on<TriggerChapterList>(_triggerChapterList);
    on<TriggerUrlItem>(_triggerUrlItem);
    on<TriggerPlay>(_triggerPlay);
    on<TriggerCheckBuyChapter>(_triggerCheckBuyChapter);
    //on<TriggerMediaIndex>(_triggerVideoIndex);
  }

  void _triggerTrailerMedia(TriggerTrailerMedia event, Emitter<TrailerState>emit) {
    emit(state.copyWith(trailerMediaItem: event.trailerMediaItem));
  }

  void _triggerChapterList(TriggerChapterList event, Emitter<TrailerState>emit){
    emit(state.copyWith(chapterListItem: event.chapterListItem));
  }
  void _triggerUrlItem(TriggerUrlItem event, Emitter<TrailerState>emit){
    emit(state.copyWith(initializeMediaPlayerFuture: event.initMediaPlayerFuture));
  }
  void _triggerPlay(TriggerPlay event, Emitter<TrailerState>emit){
    emit(state.copyWith(isPlay: event.isPlay));
  }
  _triggerCheckBuyChapter(TriggerCheckBuyChapter event, Emitter<TrailerState> emit) {
    emit(state.copyWith(checkBuy: event.checkBuy));
  }
  // void _triggerVideoIndex(TriggerMediaIndex event, Emitter<TrailerState>emit){
  //   emit(state.copyWith(mediaIndex: event.mediaIndex));
  // }
}