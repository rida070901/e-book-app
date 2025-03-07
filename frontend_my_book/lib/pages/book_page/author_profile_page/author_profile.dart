import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/pages/book_page/author_profile_page/cubit/author_prodile_cubits.dart';
import 'package:my_book/pages/book_page/author_profile_page/cubit/author_profile_states.dart';

import '../../../common/values/colors.dart';
import '../../../common/widgets/base_text_widget.dart';
import 'author_profile_controller.dart';
import 'author_profile_widgets.dart';

class AuthorProfile extends StatefulWidget {
  const AuthorProfile({super.key});

  @override
  State<AuthorProfile> createState() => _AuthorProfileState();
}

class _AuthorProfileState extends State<AuthorProfile> {

  late AuthorPageController _authorPageController;

  @override
  void didChangeDependencies() {
    _authorPageController = AuthorPageController(context: context);
    _authorPageController.init();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorProfileCubits, AuthorProfileStates>(
        builder: (context, state){
          return Scaffold(
            appBar: buildAppBar("Author Profile"),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //This container contains background image and profile photo
                    SizedBox(
                      width: 325.w,
                      height: 220.h,
                      child: Stack(
                        children: [
                          //author page background
                          backgroundImage(context, state),
                          //author page profile photo and bio
                          if(state.authorItem !=null)
                            Positioned(
                                left: 0, bottom: 0, child: authorView(context, state))
                          else
                            Container(),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    //about me and description
                    authorsDescription(state),
                    SizedBox(height: 20.h,),
                    GestureDetector(
                        onTap: (){
                          if(state.authorItem !=null){
                            _authorPageController.startChat(state.authorItem!);
                          }
                        },
                        child: reusableButton("Chat with Author")

                    ),
                    SizedBox(height: 30.h,),
                    reusableText("Author book list", color: AppColors.blackText,
                    ),
                    authorBookList(state)

                  ],
                ),
              ),
            ),
          );
        });
  }
}
