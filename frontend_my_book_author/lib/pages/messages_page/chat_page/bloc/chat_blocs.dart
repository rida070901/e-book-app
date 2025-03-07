import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_events.dart';
import 'chat_states.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState>{
  ChatBloc():super(ChatState()){
    on<TriggerMsgContentList>(_triggerMsgContentList);
    on<TriggerAddMsgContentList>(_triggerAddMsgContentList);
    on<TriggerMoreStatus>(_triggerMoreStatus);
    on<TriggerClearMsgList>(_triggerClearMsgList);
    on<TriggerLoadMsgData>(_triggerLoadMsgData);
  }

  _triggerMsgContentList(TriggerMsgContentList event, Emitter<ChatState> emit){
    //get the total messages
    var res = state.msgcontentList.toList();
    //one single message
    res.insert(0, event.msgContentList);
    //res.add(event.msgContentList); e vendos msg at the bottom of the list
    emit(state.copyWith(msgcontentList: res));
  }

  _triggerAddMsgContentList(TriggerAddMsgContentList event, Emitter<ChatState> emit){
    var res = state.msgcontentList.toList();
    res.add(event.msgContent);
    emit(state.copyWith(msgcontentList: res));
  }

  _triggerMoreStatus(TriggerMoreStatus event, Emitter<ChatState> emit){
    emit(state.copyWith(more_status: event.moreStatus));
  }

  //need to trigger the empty msg list, otherwise we will have duplicate msgs
  _triggerClearMsgList(TriggerClearMsgList event, Emitter<ChatState> emit){
    emit(state.copyWith(msgcontentList: []));
  }

  _triggerLoadMsgData(TriggerLoadMsgData event, Emitter<ChatState> emit){
    emit(state.copyWith(is_loading: event.isLoading));
  }

}