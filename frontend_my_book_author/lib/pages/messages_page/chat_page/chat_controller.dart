import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/entities/msg.dart';
import '../../../common/entities/msgcontent.dart';
import '../../../common/entities/user.dart';
import '../../../common/widgets/popMessage.dart';
import '../../../global.dart';
import 'bloc/chat_blocs.dart';
import 'bloc/chat_events.dart';

class ChatController{
  late BuildContext context;
  ChatController({required this.context});

  TextEditingController textEditingController = TextEditingController();
  ScrollController appScrollController = ScrollController();
  //get user profile info
  UserItem? userProfile = Global.storageService.getUserProfile();
  //get database instance
  final db = FirebaseFirestore.instance;
  late var docId;
  late var listener;
  bool isLoadMore = true;

  //initialization method
  void init(){
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    //the id between 2 users and is unique
    docId = data["doc_id"];

    _clearMsgNum(docId);
    _chatSnapshots();
  }

  void dispose(){
    textEditingController.dispose();
    appScrollController.dispose();
    _clearMsgNum(docId);
  }

  _clearMsgNum(String docId) async{
    var messageRes = await db
        .collection("message")
        .doc(docId)
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore())
        .get();
    if(messageRes.data()!=null){
      var item = messageRes.data()!;
      int to_msg_num = item.to_msg_num==null ? 0:item.to_msg_num!;
      int from_msg_num = item.from_msg_num==null ? 0:item.from_msg_num!;
      if(item.from_token==userProfile?.token){
        to_msg_num = 0;
      }else {
        from_msg_num = 0;
      }
      await db.collection("message").doc(docId).update({
        "to_msg_num": to_msg_num,
        "from_msg_num": from_msg_num,
      });
    }
  }

  Future<void> _chatSnapshots() async {
    var chatContext = context;
    //need to trigger the empty msg list, otherwise we will have duplicate msgs
    chatContext.read<ChatBloc>().add(const TriggerClearMsgList());
    var messages = await db.collection("message").doc(docId).collection("msglist")
    .withConverter(
      fromFirestore: Msgcontent.fromFirestore,
      toFirestore: (Msgcontent msg, options) => msg.toFirestore()
    ).orderBy("addtime", descending: true).limit(15);

    //gets called when you come to this chat page or send messages from here
    listener = messages.snapshots().listen((event) {
      //print("---------${event.docs[0].data().content}");
      List<Msgcontent> tempMsgList = <Msgcontent>[];
      for(var change in event.docChanges){
        switch(change.type){
          case DocumentChangeType.added:
            if(change.doc.data()!=null){
              tempMsgList.add(change.doc.data()!);
            }
            break;
          case DocumentChangeType.modified:
            // TODO: Handle this case.
            break;
          case DocumentChangeType.removed:
            // TODO: Handle this case.
            break;
        }
      }

      //the bottom msg comes to the top of the list
      for(var element in tempMsgList.reversed){
        //the last one will stay at the top on the UI bc we reversed
        chatContext.read<ChatBloc>().add(TriggerMsgContentList(element));
      }
    },
    onError: (error) => print("Listen failed $error")
    );

    appScrollController.addListener(() {
      //print("------listening to ui scrolls--------");
      //offset tells you how much you scrolled (starts from 0 and increases while scrolling)
      //maxScrollExtent starts 0 and changes when you start scrolling (it counts the max screen scroll extents and increases when scrolling up on the hidden stuff up)
      if((appScrollController.offset+10)>(appScrollController.position.maxScrollExtent)){
        if(isLoadMore){
          chatContext.read<ChatBloc>().add(const TriggerLoadMsgData(true));
          //trigger loading icon on
          //set isLoadMore to false
          isLoadMore = false;
          print("--------------------------------loading--------");
          //load server data
          _asyncLoadMoreData();
          //trigger loading icon off
          chatContext.read<ChatBloc>().add(const TriggerLoadMsgData(false));
        }
      }
    });
  }

  Future<void> _asyncLoadMoreData() async {
    var state = context.read<ChatBloc>().state;

    var moreMessages = await db.collection("message").doc(docId).collection("msglist")
      .withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msg, options) => msg.toFirestore(),)
      .orderBy("addtime", descending: true)
      .where("addtime", isLessThan: state.msgcontentList.last.addtime)
      .limit(10)
      .get();

    if(moreMessages.docs.isNotEmpty){
      moreMessages.docs.forEach((element) {
        //element.data() refers to a document in msglist
        var data = element.data();
        context.read<ChatBloc>().add(TriggerAddMsgContentList(data));
      });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      isLoadMore = true;
    });
    }

  }

  sendMessage() async {
    if(textEditingController.text.isEmpty){
      popMessage(message: "you can't send an empty message!");
    }else{

      String sendContent = textEditingController.text.trim();
      textEditingController.clear();

      //create a message object
      final content = Msgcontent(
        token: userProfile?.token,
        content: sendContent,
        type: "text",
        addtime: Timestamp.now(),
      );

      await db.collection("message").doc(docId).collection("msglist")
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent msg, options) => msg.toFirestore()
      ).add(content).then((DocumentReference doc){
        //print("-------after adding ${doc.id}");
      });

      var messageRes = await db.collection("message").doc(docId).withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore()
      ).get();

      if(messageRes.data()!=null){
        var item = messageRes.data()!;

        int? to_msg_num = item.to_msg_num==null ? 0:item.to_msg_num!;
        int? from_msg_num = item.from_msg_num==null ? 0:item.from_msg_num!;

        if(item.from_token==userProfile?.token){
          //sender msg count
          from_msg_num = from_msg_num+1;
        }else{
          //receiver msg count
          to_msg_num = to_msg_num+1;
        }

        //update
        await db.collection("message").doc(docId).update({
          "to_msg_num": to_msg_num,
          "from_msg_num": from_msg_num,
          "last_time": Timestamp.now(),
          "last_msg": sendContent
        });
      }
    }
  }


}