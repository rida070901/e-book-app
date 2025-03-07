import 'package:flutter_bloc/flutter_bloc.dart';
import 'chapter_events.dart';
import 'chapter_states.dart';

class ChapterBloc extends Bloc<ChapterEvent, ChapterState> {
  ChapterBloc() :super(const ChapterState()) {
    on<TriggerChapterDetailsEvent>(_triggerChapterDetailsEvent);
    on<TriggerChapterListEvents>(_triggerChapterListEvents);
  }

  _triggerChapterDetailsEvent(TriggerChapterDetailsEvent event,
        Emitter<ChapterState> emit) {
      emit(state.copyWith(chapterDetailItem: event.chapterDetailItem));
    }

  _triggerChapterListEvents(TriggerChapterListEvents event,
      Emitter<ChapterState> emit) {
    emit(state.copyWith(chapterListItem: event.chapterListItem));
  }

}