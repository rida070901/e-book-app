import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_teacher_bloc/common/values/constants.dart';
import 'package:learn_teacher_bloc/pages/messages_page/chat_list_page/cubits/chat_list_cubits.dart';
import '../../../common/entities/message.dart';
import '../../../common/routes/route_names.dart';
import '../../../common/utils/date.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/base_text_widget.dart';
import '../../../global.dart';
import 'chat_list_controller.dart';

void _removeUserData(BuildContext context){
  Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
  Global.storageService.remove(AppConstants.STORAGE_USER_PROFILE_KEY);
  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.SIGN_IN, (route) => false);
}

AppBar buildAppbar(BuildContext context) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text( "Messages", style: TextStyle(
          color: AppColors.blackText,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        )),
        SizedBox(
            width: 24.w,
            height: 24.h,
            child: GestureDetector(
                onTap: () {
                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                        title: const Text("Confirm Logout"),
                        content: const Text("Are you sure you want to log out?"),
                        actions: [
                          TextButton(
                            onPressed: ()=> Navigator.of(context).pop(),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: (){
                              _removeUserData(context);
                            },
                            child: const Text("Confirm"),
                          ),
                        ]
                    );
                  });
                },
                child: Image.asset("assets/icons/more-vertical.png")),
        ),
      ],
    ),
  );
}

Widget buildChatList(BuildContext context, Message item, ChatListController controller){
  return Container(
    width: 325.w,
    height: 80.h,
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
    child: InkWell(
      onTap: (){
        //go to chat page
        controller.startChat(item);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _cachedNetworkImage(
                  "${AppConstants.SERVER_API_URL}${item.avatar}",
                  width: 50.w,
                  height: 50.h,
                  defaultImage: "assets/icons/reading.png"),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.w),
                    width: 200.w,
                    child: reusableText("${item.name}", color: AppColors.blackText, fontSize: 13.sp, )
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, top: 10.h),
                    width: 200.w,
                    child: Text("${item.last_msg}", overflow: TextOverflow.ellipsis, maxLines: 1,),
                  )
                ],
              )
            ],
          ),
          SizedBox(width: 5,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(item.last_time==null ? "":duTimeLineFormat(
                    (item.last_time as Timestamp).toDate() ),
                  style: TextStyle(
                    color: AppColors.strongGrey,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal
                  ),
                )
              ),
              item.msg_num==0?Container()
               :Container(
                height: 15.h,
                alignment: Alignment.center,
                constraints: BoxConstraints(minWidth: 15.w),
                decoration: BoxDecoration(
                  color: AppColors.warmPink,
                  borderRadius: BorderRadius.circular(5.h)
                ),
                child: Text(
                  "${item.msg_num}",
                  style: TextStyle(
                    color: AppColors.lightText,
                    fontWeight: FontWeight.normal,
                    fontSize: 8.sp,
                  ),
                ),
              )
            ]
          )
        ],
      )
    ),
  );
}

Widget _cachedNetworkImage(
    String networkImage,{
      double? width = 60,
      double? height = 60,
      String? defaultImage,
      Widget? child,
      BoxFit boxFit = BoxFit.fitHeight
    }) {
  return CachedNetworkImage(
    imageUrl: networkImage,
    imageBuilder: (context, imageProvider) => Container(
      width: width!,
      height: height!,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.w),

        image: DecorationImage(
          image: imageProvider,
          fit: boxFit,
        ),
      ),
      child: child??const SizedBox(),
    ),
    placeholder: (context, url) => Container(
      alignment: Alignment.center,
      child:
      const Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColors.greyBackground,
            color: AppColors.warmPink,)),
    ),
    errorWidget: (context, url, error) => Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20.w),
          image: DecorationImage(
            //fit: BoxFit.fitHeight,
            image: AssetImage(
              defaultImage!,
            ),
          )),
    ),
    //show no image available image on error loading
  );
}