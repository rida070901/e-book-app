import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_teacher_bloc/common/values/colors.dart';
import 'package:learn_teacher_bloc/pages/sign_in_page/sign_in_controller.dart';
import 'package:learn_teacher_bloc/pages/sign_in_page/sign_in_widgets.dart';
import '../../common/widgets/base_text_widget.dart' as b;
import 'bloc/sign_in_blocs.dart';
import 'bloc/sign_in_events.dart';
import 'bloc/sign_in_states.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state){
        return Container(
            color: Colors.white,
            child: SafeArea(
                child: Scaffold(
                    appBar: b.buildAppBar("Author Log In", fontSize: 18),
                    body: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 70.h),
                              Center(child: b.reusableText("Use you username and password to login:", color: AppColors.warmPink)),
                              Container(
                                  margin: EdgeInsets.only(top: 66.h),
                                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        b.reusableText("Username:"),
                                        SizedBox(height: 5.h),
                                        buildTextField("Enter your username", "email", "user", (value){
                                          context.read<SignInBloc>().add(UsernameEvent(value));
                                        }), // after we grab a value(from onChanged method) we trigger an event
                                        b.reusableText("Password:"),
                                        SizedBox(height: 5.h),
                                        buildTextField("Enter your password", "password", "lock", (value){
                                          context.read<SignInBloc>().add(PasswordEvent(value));
                                        }), // after we grab a value(from onChanged method) we trigger an event
                                      ]
                                  )
                              ), //contains Column for email and password fields
                              forgotPassword(),
                              SizedBox(height: 15.h,),
                              buildLogInAdnRegButton("Log In", "login", () {
                                SignInController(context:context).handleSignIn("email");
                              }),
                            ]
                        )
                    )
                )
            )
        );
      }
    );
  }
}
