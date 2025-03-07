import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_book/common/entities/book.dart';
import 'package:my_book/common/widgets/popMessage.dart';
import 'package:my_book/global.dart';
import 'package:my_book/pages/book_page/author_profile_page/cubit/author_prodile_cubits.dart';

import '../../../common/apis/book_api.dart';
import '../../../common/entities/msg.dart';
import '../../../common/entities/user.dart';
import '../../../common/routes/route_names.dart';
import '../../../common/values/colors.dart';

class AuthorPageController {

  late BuildContext context;
  AuthorPageController({required this.context});

  UserItem? userProfile = Global.storageService.getUserProfile();
  var db = FirebaseFirestore.instance; //cloud firestore

  void init(){
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    asyncLoadAuthorData(args['token']);
    asyncLoadAuthorBookData(args['token']);
  }

  Future<void> startChat(AuthorItem author) async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(
            backgroundColor: AppColors.greyBackground, color: AppColors.warmPink),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true
    );
    //print("-------${author.token}----------");
    if(author.token == userProfile?.token){
      popMessage(message: "you cant chat to yourself");
      return;
    }

    var sentMessages = await db //msgs sent by user
      .collection("message")
      .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore())
      .where('from_token', isEqualTo: userProfile?.token) // msgs user sent to others
      .where('to_token', isEqualTo: author.token) // msgs user sent to this author
      .get();

    var receivedMessages = await db //msgs received by user
        .collection("message")
        .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('to_token', isEqualTo: userProfile?.token) // msgs sent to user
        .where('from_token', isEqualTo: author.token) // msgs sent to user by this author
        .get();

    // checking if its the first time we're chatting with this user
    if(sentMessages.docs.isEmpty && receivedMessages.docs.isEmpty){

      var msgData = Msg(
        from_token: userProfile?.token,
        to_token: author.token,
        from_name: userProfile?.name,
        to_name: author.name,
        from_avatar: userProfile?.avatar,
        to_avatar: author.avatar,
        from_online: userProfile?.online,
        to_online: author.online,
        last_msg: "",
        last_time: Timestamp.now(),
        msg_num: 0,
      );

      var docID = await db.collection("message").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore()
      ).add(msgData);

      Navigator.of(context).pushNamed(AppRoutes.CHAT_PAGE,
          arguments: {
            "doc_id": docID.id,
            "to_token": author.token??"",
            "to_name": author.name??"",
            "to_avatar": author.avatar,
            "to_online": author.online.toString(),
          });

    } else {

      if(sentMessages.docs.isNotEmpty){
        Navigator.of(context).pushNamed(AppRoutes.CHAT_PAGE,
            arguments: {
              "doc_id": sentMessages.docs.first.id,
              "to_token": author.token??"",
              "to_name": author.name??"",
              "to_avatar": author.avatar,
              "to_online": author.online.toString(),
        });
      }

      if(receivedMessages.docs.isNotEmpty){
        Navigator.of(context).pushNamed(AppRoutes.CHAT_PAGE,
            arguments: {
              "doc_id": receivedMessages.docs.first.id,
              "to_token": author.token??"",
              "to_name": author.name??"",
              "to_avatar": author.avatar,
              "to_online": author.online.toString(),
            });
      }
    }
    EasyLoading.dismiss();
  }

  Future<void> asyncLoadAuthorData(String? token) async {
    AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
    authorRequestEntity.token = token;
    var result = await BookAPI.bookAuthor(authorRequestEntity);
    if (result.code == 200) {
      if (context.mounted) {
        context.read<AuthorProfileCubits>().triggerAuthorProfile(result.data!);
        var res = jsonEncode(context.read<AuthorProfileCubits>().state.authorItem);
        //print('my author is ${res}');
      }
    }
  }

  Future<void> asyncLoadAuthorBookData(String token) async {
    AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
    authorRequestEntity.token = token;
    var result = await BookAPI.bookListAuthor(authorRequestEntity);
    if (result.code == 200) {
      if (context.mounted) {
        context.read<AuthorProfileCubits>().triggerBookItemChange(result.data!);
      }
    }
  }

}