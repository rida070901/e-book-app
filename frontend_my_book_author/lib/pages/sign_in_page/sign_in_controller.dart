import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../common/apis/user.dart';
import '../../common/entities/user.dart';
import '../../common/routes/route_names.dart';
import '../../common/values/colors.dart';
import '../../common/values/constants.dart';
import '../../common/widgets/popMessage.dart';
import '../../global.dart';
import 'bloc/sign_in_blocs.dart';

class SignInController{
  final BuildContext context;
  const SignInController({required this.context});

  Future<void> handleSignIn(String type) async {

        final state = context.read<SignInBloc>().state;
        String username = state.username;
        String password = state.password;

        LoginRequestEntity loginRequestEntity = LoginRequestEntity();
        loginRequestEntity.username = username;
        loginRequestEntity.password = password;

        await asyncPostAllData(loginRequestEntity);
  }

  Future<void> asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(
          backgroundColor: AppColors.greyBackground, color: AppColors.warmPink),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );

    var result = await UserAPI.login(params:loginRequestEntity);

    if(result.code==200){
      try {
        Global.storageService.setString(AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.data!));
        //used for authorization (thats why we saved it) --> when we make a request to our server(our endpoint) we have to send this one back
        Global.storageService.setString(AppConstants.STORAGE_USER_TOKEN_KEY, result.data!.access_token!);
        EasyLoading.dismiss();

        if(context.mounted){
          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.CHAT_LIST, (Route<dynamic> route) => false);
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