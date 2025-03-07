import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/pages/profile_page/bloc/profile_events.dart';
import 'package:my_book/pages/profile_page/bloc/profile_states.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  ProfileBloc():super(const ProfileState()){
    on<TriggerProfileName>(_triggerProfileName);
  }

  _triggerProfileName(TriggerProfileName event, Emitter<ProfileState> emit){
    emit(state.copyWith(userProfile: event.userProfile));
  }
}