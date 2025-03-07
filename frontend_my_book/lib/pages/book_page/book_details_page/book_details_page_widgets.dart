import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/common/values/constants.dart';
import 'package:my_book/common/widgets/base_text_widget.dart';
import 'package:my_book/common/widgets/popMessage.dart';
import 'package:my_book/pages/book_page/book_details_page/bloc/book_details_blocs.dart';
import 'package:my_book/pages/book_page/book_details_page/bloc/book_details_events.dart';
import 'package:my_book/pages/book_page/book_details_page/book_details_controller.dart';
import '../../../common/routes/route_names.dart';
import '../../../common/values/colors.dart';
import 'bloc/book_details_states.dart';

Widget thumbnail(String thumbnail){
  return CachedNetworkImage(
      imageUrl: thumbnail,
      placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(
              backgroundColor: AppColors.greyBackground,
              color: AppColors.warmPink,)),
      imageBuilder: (context, imageProvider){
        return Container(
          width: 325.w,
          height: 250.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.w),
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: imageProvider,
              )
          ),
        );
      }
  );
}

Widget menuView(BuildContext context, BookDetailsState state, BookDetailsController controller){
  return SizedBox(
    width:325.w,
    child: Row(
      children: [
        GestureDetector(
          onTap:(){
            Navigator.of(context).pushNamed(AppRoutes.AUTHOR_PROFILE,
            arguments: {
              //pass the token to verify persons identity for chatting
              //this is the books author token!
              "token": state.bookItem!.user_token
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColors.warmPink,
              borderRadius: BorderRadius.circular(7.w),
              border: Border.all(color: AppColors.warmPink)
            ),
            child: reusableText("Author Profile",
              color: AppColors.lightText,
              fontWeight: FontWeight.normal,
              fontSize: 10.sp,
            ),
          )
        ),
        //_iconAndNum("assets/icons/people.png", 0),
        SizedBox(width: 90.w),
        descriptionText("Add to favorites : "),
        GestureDetector(
          onTap: (){
            if((context.read<BookDetailsBloc>().state.favoriteStatus)==(null)) {
              controller.addFavorite(state.bookItem!.id);
            }else{
              controller.updateFavorite(state.bookItem!.id);
            }
          },
          child:
          ((context.read<BookDetailsBloc>().state.favoriteStatus)==(null)) || ((context.read<BookDetailsBloc>().state.favoriteStatus)==0)
              ? _favoriteIcon("assets/icons/heart.png")
              : _favoriteIcon("assets/icons/redheart.png")
        )
      ]
    )
  );
}

Widget _favoriteIcon(String iconPath){
  return Container(
      //margin: EdgeInsets.only(left: 5.w),
      child: Row(
        children: [
          Image(
            image: AssetImage(iconPath),
            width: 35.w,
            height: 35.h,
          ),
        ],
      )
  );
}

Widget _iconAndNum(String iconPath, int num){
  return Container(
    margin: EdgeInsets.only(left: 30.w),
    child: Row(
      children: [
        Image(
          image: AssetImage(iconPath),
          width: 20.w,
          height: 20.h,
        ),
        reusableText(
          num.toString(),
          color: AppColors.strongGrey,
          fontSize: 11.sp,
          fontWeight: FontWeight.normal,
        )
      ],
    )
  );
}

Widget descriptionText(String description){
  return reusableText(
      description,
      color: AppColors.greyText,
      fontWeight: FontWeight.normal,
      fontSize: 11.sp
  );
}


Widget bookDetails(BuildContext context, BookDetailsState state){

  var menuRow = <String, String> {
    "Title: ${state.bookItem!.name.toString()}" : "heart(1).png",
    "Author: ${state.bookItem!.author_name.toString()}" : "edit.png",
    "Category: ${state.bookItem!.title.toString()}" : "cube.png",
    "No. of pages: ${state.bookItem!.page_num.toString()}" : "file-text.png",
    "Language: ${state.bookItem!.language.toString()}" : "options.png",
    "Published: ${state.bookItem!.first_published_date.toString()}" : "icon.png",
    "Price: ${state.bookItem!.price.toString()} EUR": "add.png",
  };

  return Column(
      children: [
        ...List.generate(menuRow.length, (index) => GestureDetector(
            onTap: ()=> null,
            child: Container(
                margin: EdgeInsets.only(top: 15.h),
                child: Row(
                    children: [
                      Container(
                        width: 30.w,
                        height: 30.h,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          color: AppColors.warmPink,
                        ),
                        child: Image.asset("assets/icons/${menuRow.values.elementAt(index)}"),
                      ),
                      SizedBox( width: 15.w),
                      Text(
                          menuRow.keys.elementAt(index),
                          style: TextStyle(
                            color: AppColors.greyText,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp,
                          )
                      )
                    ]
                )
            )
        ),)
      ]
  );
}

Widget trailerMenu(BookDetailsState state){
  return CachedNetworkImage(
      imageUrl: state.bookItem!.thumbnail!,
      placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColors.greyBackground,
            color: AppColors.warmPink,)),
      imageBuilder: (context, imageProvider) {
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
                      offset: const Offset(0, 1)
                  )
                ]
            ),
            child: InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(AppRoutes.TRAILER_DETAILS, arguments: {
                    "id": state.bookItem!.id
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //for the image and the text
                    Row(
                      children: [
                        Container(
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.h),
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: imageProvider
                              )
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //list item title
                            _listContainerTrailer(state.bookItem!.name.toString()),
                            //list item description
                            _listContainerTrailer(state.bookItem!.description.toString(), fontSize: 10, color: AppColors.strongGrey, fontWeight: FontWeight.normal),

                          ],
                        )
                      ],
                    ),
                    //for the little arrow on the right
                    Container(
                        child: Image(
                          height: 24.h,
                          width: 24.w,
                          image: const AssetImage("assets/icons/arrow_right.png"),
                        )
                    )
                  ],
                )
            )
        );
      }
  );
}

Widget chaptersListMenu(BookDetailsState state){
  return SingleChildScrollView(

    child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.chapterListItem.length,
        itemBuilder: (context, index){
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
                          listItemContainer(state.chapterListItem[index].name.toString()),
                          //list item description
                          listItemContainer(
                              state.chapterListItem[index].title.toString(),
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
        }),
  );
}

Widget _listContainerTrailer(String name,
      {double fontSize=13,
      Color color=AppColors.blackText,
      FontWeight fontWeight=FontWeight.bold}){
  return Container(
    width: 200.w,
    margin: EdgeInsets.only(left: 6.w),
    child: Text(
      "$name movie",
      overflow: TextOverflow.clip,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontWeight: FontWeight.bold
      ),
    ),
  );
}
