import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/pages/messages_page/chat_page/bloc/chat_events.dart';
import 'package:my_book/pages/messages_page/chat_page/chat_controller.dart';
import 'package:my_book/pages/messages_page/chat_page/chat_widgets.dart';

import '../../../common/values/colors.dart';
import '../../../common/widgets/base_text_widget.dart';
import 'bloc/chat_blocs.dart';
import 'bloc/chat_states.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  late ChatController _chatController;

  @override
  void didChangeDependencies(){
    _chatController = ChatController(context: context);
    _chatController.init();
    super.didChangeDependencies();
  }

  @override
  void dispose(){
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar("Chat"),
        body: BlocBuilder<ChatBloc, ChatState>
          (builder: (context, state){
            return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  //widgets for showing messages
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 70.h),
                      child: CustomScrollView(
                        controller: _chatController.appScrollController,
                        shrinkWrap: true,
                        //default behavior is showing the 0 index first --> change with reverse
                        reverse: true, //also flips the msgs down
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (context, index){
                                  var item = state.msgcontentList[index];
                                  if(_chatController.userProfile?.token==item.token){
                                    return chatRightWidget(item);
                                  }
                                  return chatLeftWidget(item);
                                },
                                childCount: state.msgcontentList.length,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),

                  //text field and send button
                  Positioned(
                      bottom: 5.h,
                      child: Container(
                        color: AppColors.whiteBackground,
                        width: 360.w,
                        //helps going the text fields size
                        constraints: BoxConstraints(
                            maxHeight: 150.h, minHeight: 30.h
                        ),
                        padding: EdgeInsets.only(
                            left: 20.w, right: 20.w, bottom: 0.h, top:10.h
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // text field & icon button
                              Container(
                                  width: 270.w,
                                  constraints: BoxConstraints(
                                      maxHeight: 150.h, minHeight: 30.h
                                  ),
                                  decoration: BoxDecoration(
                                      color: AppColors.whiteBackground,
                                      border: Border.all(color: AppColors.unselectedGrey),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Row(
                                      children: [
                                        // for the textbox
                                        Container(
                                            constraints: BoxConstraints(
                                                maxHeight: 150.h, minHeight: 30.h
                                            ),
                                            padding: EdgeInsets.only(left: 12.w),
                                            width: 220.w,
                                            child: appTextField("message..", "none", (value){},
                                                maxLines: null, controller: _chatController.textEditingController)
                                        ),
                                        GestureDetector(
                                            onTap: (){
                                              // options to attach media
                                              context.read<ChatBloc>().add(TriggerMoreStatus(state.more_status?false:true));
                                            },
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              width: 40.w,
                                              height: 40.h,
                                              child: Image.asset("assets/icons/05.png"),
                                            )
                                        )
                                      ]
                                  )
                              ),
                              // send button
                              GestureDetector(
                                onTap: (){
                                  _chatController.sendMessage();
                                },
                                child: Container(
                                    width: 40.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        color: AppColors.warmPink,
                                        borderRadius: BorderRadius.circular(15.w),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(1,1)
                                          )
                                        ]
                                    ),
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                        width: 25.w,
                                        height: 25.h,
                                        child: Image.asset("assets/icons/icon.png")
                                    )
                                ),
                              )
                            ]
                        ),
                      )
                  ),
                  state.more_status?Positioned(
                    right: 82.w,
                    bottom: 70.h,
                    height: 100.h,
                    width: 40.w,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          chatFileButton("assets/icons/file.png"),
                          chatFileButton("assets/icons/photo.png"),
                        ]
                    ),
                  ):Container()
                ]
            );
        })
      )
    );
  }
}
