import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_teacher_bloc/pages/messages_page/chat_list_page/cubits/chat_list_cubits.dart';
import '../../global.dart';
import '../../pages/messages_page/chat_list_page/chat_list.dart';
import '../../pages/messages_page/chat_page/bloc/chat_blocs.dart';
import '../../pages/messages_page/chat_page/chat.dart';
import '../../pages/sign_in_page/bloc/sign_in_blocs.dart';
import '../../pages/sign_in_page/sign_in.dart';
import '../../pages/welcome_page/bloc/welcome_blocs.dart';
import '../../pages/welcome_page/welcome.dart';
import 'bloc_observer.dart';
import 'routes.dart';

class AppPages {
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static List<PageEntity> Routes(){
    return [
      PageEntity(
          path:AppRoutes.WELCOME,
          page:const Welcome(),
          bloc:BlocProvider(create: (_) => WelcomeBloc())
      ),
      PageEntity(
          path:AppRoutes.SIGN_IN,
          page:const SignIn(),
          bloc:BlocProvider(create: (_) => SignInBloc())
      ),
      PageEntity(
          path:AppRoutes.CHAT_LIST,
          page:const ChatList(),
          bloc:BlocProvider(create: (_) => ChatListCubit())
      ),
      PageEntity(
          path:AppRoutes.CHAT,
          page:const Chat(),
          bloc:BlocProvider(create: (_) => ChatBloc())
      ),

      /*PageEntity(
          path:AppRoutes.Profile,
          page:Profile(),
          bloc:BlocProvider(create: (_) => ProfileBloc())
      ),*/
    ];
  }

  static List<dynamic> Blocer(BuildContext context){
    List<dynamic> blocerList = <dynamic>[];
    for(var blocer in Routes()){
      blocerList.add(blocer.bloc);
    }
    return blocerList;
  }



  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings) {

      if(settings.name!=null){
        var result = Routes().where((element) => element.path==settings.name);
        if(result.isNotEmpty){
          // first open App in a specific device
         bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
         if(result.first.path==AppRoutes.WELCOME && deviceFirstOpen){
           bool isLogin = Global.storageService.getIsLogin();
           //is login
           if(isLogin){
             return MaterialPageRoute<void>(builder: (_) => const ChatList(),settings: settings);
           }
           return MaterialPageRoute<void>(builder: (_) => const SignIn(),settings: settings);
         }
          return MaterialPageRoute<void>(builder: (_) => result.first.page,settings: settings);
        }
      }
    return MaterialPageRoute<void>(builder: (_) => const SignIn(),settings: settings);
  }
}

class PageEntity<T> {
  String path;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.path,
    required this.page,
    required this.bloc,
  });
}
