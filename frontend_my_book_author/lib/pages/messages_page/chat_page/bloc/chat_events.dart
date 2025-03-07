import 'package:equatable/equatable.dart';

import '../../../../common/entities/msgcontent.dart';

abstract class ChatEvent extends Equatable{
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class TriggerMsgContentList extends ChatEvent{
  const TriggerMsgContentList(this.msgContentList);
  final Msgcontent msgContentList;

  List<Object> get props => [msgContentList];
}

class TriggerAddMsgContentList extends ChatEvent{
  const TriggerAddMsgContentList(this.msgContent);
  final Msgcontent msgContent;

  List<Object> get props => [msgContent];
}

class TriggerMoreStatus extends ChatEvent{
  const TriggerMoreStatus(this.moreStatus);
  final bool moreStatus;

  List<Object> get props => [moreStatus];
}

class TriggerClearMsgList extends ChatEvent{
  const TriggerClearMsgList();

  List<Object> get props => [];
}

class TriggerLoadMsgData extends ChatEvent{
  const TriggerLoadMsgData(this.isLoading);
  final bool isLoading;

  List<Object> get props => [isLoading];
}