import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/common/entities/chapter.dart';
import 'package:video_player/video_player.dart';
import '../../../common/routes/route_names.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/base_text_widget.dart';
import '../../../common/widgets/popMessage.dart';
import 'bloc/trailer_blocs.dart';
import 'bloc/trailer_events.dart';
import 'bloc/trailer_states.dart';
import 'trailer_controller.dart';

Widget trailerVideoPlayer(TrailerState state, TrailerController controller){
  return state.trailerMediaItem.isEmpty ? Container() : Container(
      width: 325.w,
      height: 200.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.h),
          image: const DecorationImage(
              fit:BoxFit.fitWidth,
              image: AssetImage("assets/icons/pages.gif"))
      ),
      child: FutureBuilder( //this widget gets data from server continuously(doesnt lose the connection)
        future: state.initializeMediaPlayerFuture,
        builder: (context, snapshot){
          print("---------video snapshot is ${snapshot.connectionState}");
          //check if the connection is made to the certain video on the server
          if(snapshot.connectionState==ConnectionState.done){
            return controller.videoPlayerController==null ? Container() :
            AspectRatio(
              aspectRatio: controller.videoPlayerController!.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(controller.videoPlayerController!),
                  VideoProgressIndicator(controller.videoPlayerController!, allowScrubbing: true,
                    colors: const VideoProgressColors(playedColor: AppColors.warmPink),)
                ],
              ),
            );
          }else{
            return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.greyBackground,
                  color: AppColors.warmPink,)
            );
          }
        },
      )
  );
}

Widget videoButtons(BuildContext context, TrailerState state, TrailerController controller){
  return Container(
      margin: EdgeInsets.only(top:15.h),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //left button
            GestureDetector(
                onTap: (){
                  popMessage(message: "there's only one trailer for this book");
                },
                // onTap: (){
                //   mediaIndex = mediaIndex-1;
                //   if(mediaIndex<0){
                //     mediaIndex = 0;
                //     popMessage(message: "no video there");
                //     return;
                //   }else{
                //     var mediaItem = state.editionMediaItem.elementAt(mediaIndex);
                //     _editionController.playVideo(mediaItem.url!);
                //   }
                // },
                child: Container(
                  width: 24.w,
                  height: 24.h,
                  margin: EdgeInsets.only(right:35.w),
                  child: Image.asset("assets/icons/rewind-left.png"),
                )
            ),
            //play and pause button
            GestureDetector(
                onTap: (){
                  if(state.isPlay){
                    // ----if its alrd playing
                    controller.videoPlayerController?.pause();
                    context.read<TrailerBloc>().add(const TriggerPlay(false));
                  }else{
                    // -----if its not playing, then play
                    controller.videoPlayerController?.play();
                    context.read<TrailerBloc>().add(const TriggerPlay(true));
                  }
                },
                child: state.isPlay ? SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: Image.asset("assets/icons/pause.png"),
                ) :SizedBox(
                  width: 30.w,
                  height: 24.h,
                  child: Image.asset("assets/icons/play-circle.png"),
                )
            ),
            //right button
            GestureDetector(
                onTap: (){
                  popMessage(message: "there's only one trailer for this book");
                },
                // onTap: (){
                //   mediaIndex = mediaIndex+1;
                //   if(mediaIndex>=state.editionMediaItem.length){
                //     mediaIndex = mediaIndex-1;
                //     popMessage(message: "no video there");
                //     return;
                //   }else{
                //     var mediaItem = state.editionMediaItem.elementAt(mediaIndex);
                //     _editionController.playVideo(mediaItem.url!);
                //   }
                // },
                child: Container(
                  width: 24.w,
                  height: 24.h,
                  margin: EdgeInsets.only(left:35.w),
                  child: Image.asset("assets/icons/rewind-right.png"),
                )
            ),
          ]
      )
  );
}

/*SliverPadding editionList(EditionState state){
  return SliverPadding( padding: EdgeInsets.symmetric(
    vertical: 18.h,
    horizontal: 25.w,
  ),
    sliver: SliverList(
      delegate: SliverChildBuilderDelegate(
              (context, index){
            return state.editionItem.isEmpty ? Container() : _buildEditionItem(state, context, index, state.editionItem[index]);
          },
          childCount: state.editionItem.length
      ),
    ),
  );

}

Widget _buildEditionItem(EditionState state, BuildContext context, int index, EditionItem item){
  return CachedNetworkImage(
      imageUrl: item.thumbnail!,
      placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColors.greyBackground,
            color: AppColors.warmPink,)),
            imageBuilder: (context, imageProvider) {
              return Container(
                  width: 325.w,
                  height: 80.h,
                  margin: EdgeInsets.only(bottom: 20.h),
                  padding: EdgeInsets.symmetric(vertical:10.h, horizontal:10.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: const Color.fromRGBO(255,255,255,1),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(0,1))
                      ]
                  ),
                  child: InkWell(
                      onTap: (){
                        if(state.checkBuy==true){
                          // Navigator.of(context).pushNamed(AppRoutes.READ_EDITION, arguments: {
                          //   "id":state.editionItem[index].id
                          // });
                          popMessage(message: "ok");
                        }else{
                          popMessage(message: "You need to but this book first");
                        }
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 60.w,
                                      height: 60.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15.w),
                                          image: DecorationImage(
                                              fit: BoxFit.fitHeight,
                                              image: NetworkImage("${item.thumbnail}")
                                          )
                                      )
                                  ),
                                  Container(
                                    width: 170.w,
                                    height: 60.h,
                                    margin: EdgeInsets.only(left: 6.sp),
                                    alignment: Alignment.centerLeft,
                                    child: reusableText("${item.name}", fontSize: 13.sp),
                                  ),
                                ]
                            ),
                            Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      if(state.checkBuy==true){
                                        // Navigator.of(context).pushNamed(AppRoutes.READ_EDITION, arguments: {
                                        //   "id":state.editionItem[index].id
                                        // });
                                        popMessage(message: "ok");
                                      }else{
                                        popMessage(message: "You need to but this book first");
                                      }
                                    },
                                    child: Container(
                                        width: 65.w,
                                        height: 25.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15.w),
                                            image: const DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage("assets/icons/start.jpg")
                                            )
                                        )
                                    ),
                                  )
                                ]
                            )
                          ]
                      )
                  )
              );
      }
  );
}
*/

SliverPadding chaptersListMenu(TrailerState state){
  return SliverPadding( padding: EdgeInsets.symmetric(
    vertical: 18.h,
    horizontal: 25.w,
  ),
    sliver: SliverList(
      delegate: SliverChildBuilderDelegate(
              (context, index){
            return state.chapterListItem.isEmpty ? Container() : _chaptersListMenu(context, state, index, state.chapterListItem[index]);
          },
          childCount: state.chapterListItem.length
      ),
    ),
  );

}



Widget _chaptersListMenu(BuildContext context, TrailerState state, int index, ChapterListItem item){
  return Container(
    margin: EdgeInsets.only(top: 10.h),
    width: 325.w,
    height: 80.h,
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(10.w),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 1))
        ]),
    child: InkWell(
      onTap: () {
        if(state.checkBuy==true){
          Navigator.of(context).pushNamed(AppRoutes.CHAPTER, arguments: {
            "clicked_chapter_id": state.chapterListItem[index].id,
            "chapter_list": state.chapterListItem,
          });
        }else{
          popMessage(message: "You need to but this book first");
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //for image and the text
          Row(
            children: [
              Container(
                width: 35.w,
                height: 35.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.h),
                    image:  DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: state.checkBuy==false
                            ? const AssetImage("assets/icons/lock.jpg")
                            : const AssetImage("assets/icons/unlock.jpg"))),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //list item title
                  listItemContainer(item.name.toString()),
                  //list item description
                  listItemContainer(
                      item.title.toString(),
                      fontSize: 10,
                      color: AppColors.strongGrey,
                      fontWeight: FontWeight.normal)
                ],
              )
            ],
          ),
          //for showing the right arrow
          Container(
            child: Image(
              height: 24.h,
              width: 24.h,
              image: const AssetImage("assets/icons/arrow_right.png"),
            ),
          )
        ],
      ),
    ),
  );
}