import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/base_text_widget.dart';
import 'chat_list_controller.dart';
import 'chat_list_widgets.dart';
import 'cubits/chat_list_cubits.dart';
import 'cubits/chat_list_states.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  late ChatListController _chatListController;

  @override
  void didChangeDependencies() {
    _chatListController = ChatListController(context: context);
    _chatListController.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: BlocBuilder<ChatListCubit, ChatListState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
                appBar: buildAppbar(context),
                body: state.loadStatus==true
                    ?const Center(child: CircularProgressIndicator(
                    backgroundColor: AppColors.greyBackground,
                    color: AppColors.warmPink))
                    :CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 0.h),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (_, index){
                            var item = state.message.elementAt(index);
                            //print("----------------${item.token}");
                            return buildChatList(context, item, _chatListController);
                          },
                          childCount: state.message.length,
                        ),
                      ),
                    )
                  ],
                )
            );
          },
        )
      ),
    );
  }
}
