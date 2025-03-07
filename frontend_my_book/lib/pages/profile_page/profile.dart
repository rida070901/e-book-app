import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/common/widgets/base_text_widget.dart';
import 'package:my_book/pages/profile_page/profile_widgets.dart';

import '../../common/values/colors.dart';
import '../../global.dart';
import 'bloc/profile_blocs.dart';
import 'bloc/profile_events.dart';
import 'bloc/profile_states.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    var userProfile = Global.storageService.getUserProfile();
    print('user profile is ${jsonEncode(userProfile)}');
    context.read<ProfileBloc>().add(TriggerProfileName(userProfile!));

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state){
        return Scaffold(
            appBar: buildAppbar(context),
            body: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //for the profile icon
                        profileIconAndEditButton(),
                        SizedBox(height:30.h),
                        //for the username row
                        buildProfileName(state),
                        //for the row buttons
                        profileRowMenu(context),
                        //for the column buttons
                        Padding(
                          padding: EdgeInsets.only(left: 25.w,),
                          child: profileColumnMenu(context),
                        ),
                      ]
                  ),
                )
            )
        );
      }
    );
  }
}
