import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_book/common/entities/entities.dart';
import 'package:my_book/common/values/constants.dart';
import 'package:my_book/pages/home_page/home_page_controller.dart';
import '../../common/apis/user_api.dart';
import '../../common/values/colors.dart';
import '../../common/widgets/popMessage.dart';
import '../../global.dart';
import 'bloc/sign_in_blocs.dart';

class SignInController{
  final BuildContext context;
  SignInController({required this.context});
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> handleSignIn(String type) async {
    try{
      if(type=="email"){
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;

        if(emailAddress.isEmpty){
          popMessage(message: "Email should not be empty!");
          return;
        }
        if(password.isEmpty){
          popMessage(message: "Password should not be empty!");
          return;
        }
        try{
          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailAddress , password: password);

          var user = credential.user;
          if(user==null){ //check if user exists from firebase
            popMessage(message: "User does not exist");
            return;
          }
          if(!user!.emailVerified){ //check if user has verified acc from email
            popMessage(message: "Email not verified. Please verify your email first.");
            return;
          }
          if(user!=null){
            //print("user exists (verified from firebase)");

            String? displayName = user.displayName;
            String? email = user.email;
            String? id = user.uid;
            String? photoUrl = user.photoURL;

            LoginRequestEntity loginRequestEntity = LoginRequestEntity();//LoginRequestEntity(avatar: photoUrl, type:1, name: displayName, email: email, open_id: id, online: 1, phone: "06933333", description: "desccc gdsh" );
            loginRequestEntity.avatar = photoUrl;
            loginRequestEntity.name = displayName;
            loginRequestEntity.email = email;
            loginRequestEntity.open_id = id;
            loginRequestEntity.type = 1; //type 1 means email login

            await asyncPostAllData(loginRequestEntity);

            if(context.mounted){
              await HomeController(context:context).init();
            }

          }else{
            popMessage(message: "User not found.");
            //print("user not found ???!!");
            return;
          }
        }on FirebaseAuthException catch(e){
          if(e.code=='user-not-found'){
            popMessage(message: "User Not Found!");
          }
          else if(e.code=='wrong-password'){
            popMessage(message: "Wrong Password!");
          }
          else if(e.code=='invalid-email'){
            popMessage(message: "Invalid Email!");
          }
          //print(e.toString());
        }
      }


      if(type=="google"){
        try{
          final user = await _googleSignIn.signIn();

          if(user==null){ //check if user exists from firebase
            popMessage(message: "User does not exist");
            //print("user doesnt exist");
            return;
          }

            String? displayName = user.displayName;
            String? email = user.email;
            String? id = user.id;
            String? photoUrl = user.photoUrl??"${AppConstants.SERVER_API_URL}uploads/default.png";

            LoginRequestEntity loginRequestEntity = LoginRequestEntity();//LoginRequestEntity(avatar: photoUrl, type:1, name: displayName, email: email, open_id: id, online: 1, phone: "06933333", description: "desccc gdsh" );
            loginRequestEntity.avatar = photoUrl;
            loginRequestEntity.name = displayName;
            loginRequestEntity.email = email;
            loginRequestEntity.open_id = id;
            loginRequestEntity.type = 2; //google login

            await asyncPostAllData(loginRequestEntity);

            if(context.mounted){
              await HomeController(context:context).init();
            }

        }on FirebaseAuthException catch(e){
          if(e.code=='user-not-found'){
            popMessage(message: "User Not Found!");
          }
          else if(e.code=='wrong-password'){
            popMessage(message: "Wrong Password!");
          }
          else if(e.code=='invalid-email'){
            popMessage(message: "Invalid Email!");
          }
          //print(e.toString());
        }
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(
          backgroundColor: AppColors.greyBackground, color: AppColors.warmPink),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );

    var result = await UserAPI.login(params:loginRequestEntity);

  //   print("my result here is ${result.code}");

    if(result.code==200){
      try {
        Global.storageService.setString(AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.data!));
        EasyLoading.dismiss();
        //used for authorization (thats why we saved it) --> when we make a request to our server(our endpoint) we have to send this one back
        Global.storageService.setString(AppConstants.STORAGE_USER_TOKEN_KEY, result.data!.access_token!);
        if(context.mounted){
          Navigator.of(context).pushNamedAndRemoveUntil("/app_start_page", (route) => false);
        }
      } catch(e){
        print("saving local storage error: ${e.toString()}");
      }
    }else{
      EasyLoading.dismiss();
      popMessage(message: "unknown error");
    }
  }
}