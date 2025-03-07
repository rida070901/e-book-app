import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/pages/sign_up_page/sign_up_controller.dart';

import '../common_widgets.dart';
import 'bloc/sign_up_blocs.dart';
import 'bloc/sign_up_events.dart';
import 'bloc/sign_up_states.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state){
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar("Sign Up"),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox (height: 20.h,),
                  Center(
                      child: reusableText("Enter your details below to sign up")),
                  Container(
                    margin: EdgeInsets.only(top: 60.h),
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reusableText("User Name"),
                        buildTextField("Enter your name", "name", "user", (value) {
                          context.read<SignUpBloc>().add(UsernameEvent(value));
                        }),
                        reusableText("Email"),
                        buildTextField("Enter your email address", "email", "user", (value){
                          context.read<SignUpBloc>().add(EmailEvent(value));
                        }),
                        reusableText("Password"),
                        buildTextField("Enter your password", "password", "lock", (value){
                          context.read<SignUpBloc>().add(PasswordEvent(value));
                        }),
                        reusableText("Confirm Your Password"),
                        buildTextField("Re-enter your password to confirm", "password", "lock", (value){
                          context.read<SignUpBloc>().add(ConfirmPasswordEvent(value));
                        })
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25.w),
                    child: reusableText("By creating an account you voluntary agree with our terms & conditions."),
                  ),
                  buildLogInAdnRegButton("Sign Up", "login", () {
                    SignUpController(context: context).handleEmailRegister();
                  }),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
