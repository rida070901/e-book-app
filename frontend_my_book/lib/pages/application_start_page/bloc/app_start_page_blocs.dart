import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_start_page_events.dart';
import 'app_start_page_states.dart';

class AppBloc extends Bloc<AppEvent, AppState>{
  AppBloc():super(const AppState()){
    on<TriggerAppEvent>((event, emit){
      emit(AppState(index:event.index));
    });
  }

}

