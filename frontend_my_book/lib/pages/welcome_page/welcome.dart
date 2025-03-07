import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/common/values/colors.dart';
import 'package:my_book/pages/welcome_page/bloc/welcome_blocs.dart';
import 'package:my_book/pages/welcome_page/bloc/welcome_events.dart';
import '../../common/values/constants.dart';
import '../../global.dart';
import 'bloc/welcome_states.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Scaffold(
          body: BlocBuilder<WelcomeBloc, WelcomeState>(
            builder: (context, state){
              return Container(
                margin: EdgeInsets.only(top:34.h),
                width: 375.w,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    PageView(
                      controller: pageController,
                      onPageChanged: (index){
                        state.page = index;
                        BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvent());

                      },
                      children: [
                        _page(
                            1,
                            context,
                            "Next",
                            "Welcome to e-Books World!",
                            "Forget about spending a ton of money and space for paper books, explore the e-book world!",
                            "assets/images/girlreadingbooks.jpg"
                        ),
                        _page(
                            2,
                            context,
                            "Next",
                            "Connect With Everyone",
                            "Always keep in touch with your favorite authors & friends.",
                            "assets/images/laptopandbooks.jpg"
                        ),
                        _page(
                            3,
                            context,
                            "Lets get Started!",
                            "Always Fascinated Learning",
                            "Discover new characters and new worlds, anywhere, anytime.",
                            "assets/images/ebooks.PNG"
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 100.h,
                      child: DotsIndicator(
                        position: state.page,
                        dotsCount: 3,
                        mainAxisAlignment: MainAxisAlignment.center,
                        decorator: DotsDecorator(
                            color: AppColors.strongGrey,
                            activeColor: AppColors.warmPink,
                            size: const Size.square(8.0),
                            activeSize:  const Size(18.0, 8.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            )
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )
      ),
    );
  }

  Widget _page(int index, BuildContext context, String buttonName, String title
      ,String subTitle, String imagePath){
    return Column(
      children: [
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
          width: 345.w,
          height: 345.w,
          child:  Image.asset(
            imagePath,
            fit: BoxFit.cover,

          ),
        ),
        SizedBox(
          height: 35.h,
        ),
        Container(
          child: Text(
            title,
            style: TextStyle(
                color: AppColors.blackText,
                fontSize: 24.sp,
                fontWeight: FontWeight.normal
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Container(
          width: 375.w,
          padding:  EdgeInsets.only(left: 30.w, right: 30.w),
          child: Text(
            subTitle,
            style: TextStyle(
                color:AppColors.greyText,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            //within 0-2 index
            if(index<3){
              //animation
              pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeIn
              );

            }else{
              //jump to a new page
             // print("welcome - first time app");
              Global.storageService.setBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
              Navigator.of(context).pushNamedAndRemoveUntil("/sign_in", (route) => false);
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 80.h, left: 25.w, right: 25.w),
            width: 325.w,
            height: 50.h,

            decoration: BoxDecoration(
                color:AppColors.warmPink,
                borderRadius: BorderRadius.all(Radius.circular(15.w)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset:Offset(0, 1)
                  )
                ]
            ),
            child: Center(
              child: Text(buttonName,

                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
