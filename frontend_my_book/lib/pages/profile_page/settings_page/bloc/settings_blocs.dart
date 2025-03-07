import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/pages/profile_page/settings_page/bloc/settings_events.dart';
import 'package:my_book/pages/profile_page/settings_page/bloc/settings_states.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState>{
  SettingsBloc():super(const SettingsState()){
    on<TriggerSettings>(_triggerSettings);
  }
  _triggerSettings(SettingsEvent event, Emitter<SettingsState> emit){
    emit(const SettingsState());
  }
}