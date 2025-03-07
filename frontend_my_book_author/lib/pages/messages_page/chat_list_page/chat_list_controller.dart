import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/entities/message.dart';
import '../../../common/entities/msg.dart';
import '../../../common/entities/user.dart';
import '../../../common/routes/route_names.dart';
import '../../../global.dart';
import 'cubits/chat_list_cubits.dart';

class ChatListController{
  late BuildContext context;
  ChatListController({required this.context});
  final db = FirebaseFirestore.instance;
  UserItem? userProfile = Global.storageService.getUserProfile();
  StreamSubscription<QuerySnapshot<Object?>>? listener1;
  StreamSubscription<QuerySnapshot<Object?>>? listener2;

  Future<void> init() async {
    await _snapshots();
  }

  Future<void> startChat(Message item) async {
    var nav = Navigator.of(context);
    if(item.doc_id!=null){
      if(listener1!=null && listener2!=null){
        await listener1?.cancel();
        await listener2?.cancel();
      }
    }
    nav.pushNamed(AppRoutes.CHAT, arguments: {
      "doc_id": item.doc_id,
      "to_token": item.token!,
      "to_avatar": item.avatar!,
      "to_online": item.online!,
    }).then((value) => _snapshots()); //cancel and reactivate (better than keeping it alive)
  }

   _snapshots(){
    var token = userProfile?.token;

    //returns document
    final receivedMessageRef = db //teachers msgs to user
      .collection("message")
      .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore())
      .where("to_token", isEqualTo: token); //to_token is teachers token

    //returns document
    final sentMessageRef = db //users msgs to teacher -> get the fb object
        .collection("message")
        .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_token", isEqualTo: token); //from_token is users token

    //listen if you send a msg or if someone sends a msg to you
    listener1 = receivedMessageRef.snapshots().listen((event) async {
      await _asyncLoadMsgData();
    });
    listener2 = sentMessageRef.snapshots().listen((event) async {
      await _asyncLoadMsgData();
    });
  }

  _asyncLoadMsgData() async {
    var msgContext = context.read<ChatListCubit>();

    final sentMessageRef = await db
        .collection("message")
        .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_token", isEqualTo: userProfile?.token) //from_token is senders token
        .get();

    final receivedMessageRef = await db
        .collection("message")
        .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("to_token", isEqualTo: userProfile?.token) //to_token is receivers token
        .get();

    List<Message> messageList = <Message>[];
    if(receivedMessageRef.docs.isNotEmpty){
      var message = await _addMessage(receivedMessageRef.docs);
      messageList.addAll(message);
    }
    if(sentMessageRef.docs.isNotEmpty){
      var message = await _addMessage(sentMessageRef.docs);
      messageList.addAll(message);
    }
    //sorting the messages in chatlist page according to time
    //the latest msg stays on top
    messageList.sort((a, b){
      if(b.last_time==null) return 0;
      if(a.last_time==null) return 0;
      return b.last_time!.compareTo(a.last_time!);
    });
      msgContext.messageChanged(messageList);
      msgContext.loadStatusChanged(false);
  }

  Future<List<Message>> _addMessage(List<QueryDocumentSnapshot<Msg>> data) async{
    List<Message> messageList = <Message>[];
    data.forEach((element){
      var item = element.data(); //refers to one specific message document (from message collection)
      Message message = Message();
      message.doc_id = element.id;
      message.last_time = item.last_time;
      message.msg_num = item.msg_num;
      message.last_msg = item.last_msg;

      //check if the message documents from_token matches our users token
      //--> to get info from chats that are sent by this user
      if(item.from_token==userProfile?.token){
        //if tokens match -> get the teachers info to show on chatlist page
        message.name = item.to_name;
        message.avatar = item.to_avatar;
        message.online = item.to_online??0;
        message.msg_num = item.to_msg_num??0;
        message.token = item.to_token;
      }else{
        //the teacher started the chat so from_token(the senders token) is teachers token
        message.name = item.from_name;
        message.avatar = item.from_avatar;
        message.online = item.from_online??0;
        message.msg_num = item.from_msg_num??0;
        message.token = item.from_token;
      }
      messageList.add(message);
    });
    return messageList;
  }
}