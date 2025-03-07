import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/pages/book_page/author_profile_page/cubit/author_profile_states.dart';

import '../../../common/routes/route_names.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/constants.dart';
import '../../../common/widgets/base_text_widget.dart';

Widget backgroundImage(BuildContext context, AuthorProfileStates state) {
  return Container(
      //margin: EdgeInsets.only(bottom: 10.h),
      child: state.authorItem == null
        ? Container()
        : Container(
            child: _cachedNetworkImage("${AppConstants.SERVER_UPLOADS}${state.authorItem!.bg_image}" ?? "",
              width: 325.w,
              height: 160.h,
              defaultImage: "assets/icons/background.png",
              boxFit: BoxFit.fitWidth),
    )
  );
}

Widget authorView(BuildContext context, AuthorProfileStates state) {
  return Container(
    width: 325.w,
    margin: EdgeInsets.only(left: 20.w, bottom: 1.w),
    child: state.authorItem == null
        ? Container()
        : Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //author's profile photo
        _cachedNetworkImage("${state.authorItem!.avatar}" ?? "",
            width: 80.w,
            height: 80.h,
            defaultImage: "assets/icons/person(1).png"),

        //author bio
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            //author's name
            Container(
              margin: EdgeInsets.only(left: 6.w, top: 7.h),
              child: reusableText(state.authorItem?.name ?? "Unknown",
                  color: AppColors.blackText, fontSize: 13),
            ),
            //author's job
            Container(
              margin: EdgeInsets.only(left: 6.w, bottom: 7.h),
              child: reusableText(state.authorItem?.job ?? "Book Author",
                  color: AppColors.greyText,
                  fontSize: 9,
                  fontWeight: FontWeight.normal),
            ),
            //author's popularity
            authorsPopularity()
          ],
        )
      ],
    ),
  );
}

Widget authorsPopularity() {
  return Row(
    children: [
      //author's fans
      _iconAndNum("assets/icons/people.png", 121),
      SizedBox(
        width: 8.w,
      ),
      _iconAndNum("assets/icons/star.png", 12),
      SizedBox(
        width: 8.w,
      ),
      _iconAndNum("assets/icons/download.png", 102),
    ],
  );
}

Widget _iconAndNum(String iconPath, int num) {
  return Container(
    //margin: EdgeInsets.only(left: 30.w),
    child: Row(
      children: [
        Image(
          image: AssetImage(iconPath),
          width: 16.w,
          height: 16.h,
        ),
        reusableText(num.toString(),
            color: AppColors.strongGrey,
            fontSize: 11.sp,
            fontWeight: FontWeight.normal)
      ],
    ),
  );
}

Widget authorsDescription(AuthorProfileStates state) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //about me text
      reusableText(
        "About me",
        color: AppColors.blackText,
      ),
      //about authors description
      state.authorItem == null
          ? Container()
          : reusableText(
        state.authorItem!.description ?? "No description found",
        color: AppColors.blackText,
        fontWeight: FontWeight.normal,
        fontSize: 11.sp,
      )
    ],
  );
}

Widget authorBookList(AuthorProfileStates state) {
  return SingleChildScrollView(
    child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.bookItem.length,
        itemBuilder: (context, index) {
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
                Navigator.of(context).pushNamed(AppRoutes.BOOK_DETAILS ,
                    arguments: {
                      "id":state.bookItem[index].id
                    }

                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //for image and the text
                  Row(
                    children: [
                      _cachedNetworkImage(
                          state.bookItem[index].thumbnail!,
                          width: 60.w,
                          height: 60.h,
                          defaultImage: "assets/icons/reading.png"
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //list item title
                          listItemContainer(
                              state.bookItem[index].name.toString()),
                          //list item description
                          listItemContainer(
                              "${state.bookItem[index].price.toString()} EUR",
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
                      image: AssetImage("assets/icons/arrow_right.png"),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
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
        borderRadius: BorderRadius.circular(20.w),

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

