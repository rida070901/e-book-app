import '../../../../common/entities/message.dart';

class ChatListState{
  const ChatListState({this.message = const <Message>[], this.loadStatus = true});

  final List<Message> message;
  final bool loadStatus;

  ChatListState copyWith({List<Message>? message, bool? loadStatus}){
    return ChatListState(
      message: message ?? this.message,
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }
}