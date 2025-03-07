import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/common/values/constants.dart';
import 'package:my_book/pages/home_page/bloc/home_page_states.dart';
import 'package:my_book/pages/home_page/home_page_controller.dart';
import '../../common/entities/book.dart';
import '../../common/values/colors.dart';
import 'bloc/home_page_blocs.dart';
import 'bloc/home_page_events.dart';

AppBar buildAppBarHomePage(String avatar) {
  return AppBar(
    title: Container(
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 15.w,
            height: 12.h,
            child: Image.asset("assets/icons/menu.png"),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: 10.h),
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/icons/reading.png"))),
            ),//NetworkImage("${AppConstants.SERVER_API_URL}$avatar")
          )
        ],
      ),
    ),
  );
}

//reusable big text widget
Widget homePageText(String text, {Color color = AppColors.blackText, int top = 20}) {
  return Container(
    margin: EdgeInsets.only(top: top.h),
    child: Text(
      text,
      style:
      TextStyle(color: color, fontSize: 24.sp, fontWeight: FontWeight.bold),
    ),
  );
}

//search section
Widget searchSection(){
  return Row(
    children: [
      Container(
        margin: EdgeInsets.only(top: 15.h),
        width: 280.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.whiteBackground,
          borderRadius: BorderRadius.circular(15.h),
          border: Border.all(color: AppColors.unselectedGrey)
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left:17.w),
              width: 16.w,
              child: Image.asset("assets/icons/search.png"),
            ),
            SizedBox(
              width: 240.w,
              height: 40.h,
              child: TextField(
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                  hintText: "Search book ...",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  hintStyle: TextStyle( color: AppColors.greyText),
                ),
                style: TextStyle(
                    color: AppColors.blackText,
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp),
                autocorrect: false,
                obscureText: false,
              ),
            )
          ]
        )
      ),
      SizedBox(width: 5.w),
      GestureDetector(
        child: Container(
          margin: EdgeInsets.only(top: 15.h),
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.warmPink,
            borderRadius: BorderRadius.all(Radius.circular(13.w)),
            border: Border.all(color: AppColors.warmPink),
          ),
          alignment: Alignment.center,
          child: SizedBox(
            width: 30.w,
            height: 30.h,
            child: Image.asset("assets/icons/options.png"),
          )
        ),
      )
    ]
  );
}

//slide menu
Widget slideMenu(BuildContext context, HomePageState state){
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(top: 20.h),
        width: 325.w,
        height: 160.h,
        child: PageView(
            onPageChanged: (value) {
              //print("my value is");
              //print(value.toString());
              context.read<HomePageBloc>().add(HomePageDots(value));
            },
          children: [
            _slide(path: "assets/images/quote2.webp"),
            _slide(path: "assets/images/slide1.jpg"),
            _slide(path: "assets/images/slide2.jpg"),
          ]
        )
      ),
      DotsIndicator(
        dotsCount: 3,
        position: state.index,
        decorator: DotsDecorator(
            color: AppColors.strongGrey,
            activeColor: AppColors.warmPink,
            size: const Size.square(5.0),
            activeSize: const Size(17.0, 5.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0))),
      )
    ]
  );
}

//slider container
Widget _slide({String path="assets/images/slide.jpg"}){
  return Container(
    width: 325.w,
    height: 160.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.h)),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(path),
        )
    ),
  );
}

//navigate different books -- menu section
Widget menuView(BuildContext context, HomeController controller, HomePageState state) {
  return Column(
    children: [
      Container(
          width: 325.w,
          margin: EdgeInsets.only(top: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _reusableText("Choose your book"),
              GestureDetector(
                  child: _reusableText("See all", color: AppColors.strongGrey, fontSize: 10)),
            ],
          )),
      Container(
        margin: EdgeInsets.only(top: 20.w),
        child: Row(
          children: [
            GestureDetector(
              onTap: (){
                context.read<HomePageBloc>().add(const BookListIndex(0));
                controller.asyncPopularBookList();
                _reusableMenuText("Popular", state);
              },
              child: state.bookListIndex==0 ? _reusableMenuText("Popular", state)
              :_reusableMenuText("Popular", state, textColor:AppColors.strongGrey, bgColor:AppColors.whiteBackground),
            ),
            GestureDetector(
              onTap: (){
                context.read<HomePageBloc>().add(const BookListIndex(1));
                controller.asyncRandomBookList();
              },
              child: state.bookListIndex==1 ? _reusableMenuText("Random", state)
              :_reusableMenuText("Random", state, textColor:AppColors.strongGrey, bgColor:AppColors.whiteBackground),
            ),
            GestureDetector(
              onTap: (){
                context.read<HomePageBloc>().add(const BookListIndex(2));
                controller.asyncNewBookList();
              },
              child: state.bookListIndex==2 ? _reusableMenuText("Newest", state)
              : _reusableMenuText("Newest", state, textColor:AppColors.strongGrey, bgColor:AppColors.whiteBackground),
            ),
            GestureDetector(
              onTap: (){
                context.read<HomePageBloc>().add(const BookListIndex(3));
                controller.asyncEconomicBookList();
              },
              child: state.bookListIndex==3 ? _reusableMenuText("Economic", state)
                  : _reusableMenuText("Economic", state, textColor:AppColors.strongGrey, bgColor:AppColors.whiteBackground),
            ),
            ],
        ),
      )
    ],
  );
}

//for the menu buttons, reusable text
Widget _reusableMenuText(String menuText, HomePageState state,
    {Color textColor = AppColors.lightText, Color bgColor = AppColors.warmPink}){
  return Container(
    margin: EdgeInsets.only(right: 8.w,),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(7.w),
      border: Border.all(color: AppColors.whiteBackground),
    ),
    padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 5.h, bottom: 5.h),
    child: _reusableText(
      menuText,
      color: textColor,
      fontWeight: FontWeight.normal,
      fontSize: 11,
    )
  );
}

Widget _reusableText(String text,
    {Color color = AppColors.blackText, int fontSize = 16, FontWeight fontWeight = FontWeight.bold}){
  return Text( text, style: TextStyle( color:color, fontWeight:fontWeight, fontSize: fontSize.sp),
  );
}

Widget bookGrid(BookItem item) {
  return CachedNetworkImage(
    imageUrl: item.thumbnail!, //"${AppConstants.SERVER_API_URL}${item.thumbnail!}",
    placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColors.greyBackground,
          color: AppColors.warmPink,)),
    imageBuilder: (context, imageProvider){
      return Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
            image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fitWidth,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name??"",
              maxLines: 1,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.left,
              softWrap: false,
              style: TextStyle(
                  color: AppColors.warmPink,
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp),
            ),
            SizedBox(height: 5.h,),
            Text(
              "${item.page_num} pages" ??"",
              maxLines: 1,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.left,
              softWrap: false,
              style: TextStyle(
                  color: AppColors.unselectedGrey,
                  fontWeight: FontWeight.normal,
                  fontSize: 8.sp),
            )
          ],
        ),
      );
    },
  );
}