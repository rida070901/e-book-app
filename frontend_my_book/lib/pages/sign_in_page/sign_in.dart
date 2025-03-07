import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/pages/sign_in_page/sign_in_controller.dart';
import 'bloc/sign_in_blocs.dart';
import 'bloc/sign_in_events.dart';
import 'bloc/sign_in_states.dart';
import 'package:my_book/pages/common_widgets.dart';

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
                    appBar: buildAppBar("Log In"),
                    body: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildThirdPartyLogin(context),
                              Center(child: reusableText("Or use your email")),
                              Container(
                                  margin: EdgeInsets.only(top: 66.h),
                                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        reusableText("Email"),
                                        SizedBox(height: 5.h),
                                        buildTextField("Enter your email address", "email", "user", (value){
                                          context.read<SignInBloc>().add(EmailEvent(value));
                                        }), // after we grab a value(from onChanged method) we trigger an event
                                        reusableText("Password"),
                                        SizedBox(height: 5.h),
                                        buildTextField("Enter your password", "password", "lock", (value){
                                          context.read<SignInBloc>().add(PasswordEvent(value));
                                        }), // after we grab a value(from onChanged method) we trigger an event
                                      ]
                                  )
                              ), //contains Column for email and password fields
                              forgotPassword(),
                              SizedBox(height: 70.h,),
                              buildLogInAdnRegButton("Log In", "login", () {
                                SignInController(context:context).handleSignIn("email");
                              }),
                              buildLogInAdnRegButton("Sign Up", "register", () {
                                // jump to sign in page
                                Navigator.of(context).pushNamed("/sign_up");
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
