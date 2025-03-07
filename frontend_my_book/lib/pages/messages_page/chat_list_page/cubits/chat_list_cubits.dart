import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/entities/message.dart';
import 'chat_list_states.dart';

class ChatListCubit extends Cubit<ChatListState>{
  ChatListCubit():super(const ChatListState());

  //during message load
void loadStatusChanged(bool loadStatus){
  emit(state.copyWith(loadStatus: loadStatus));
}

void messageChanged(List<Message> message){
  emit(state.copyWith(message: message));
}
}