import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_book/pages/home_page/bloc/home_page_events.dart';
import 'package:my_book/pages/home_page/bloc/home_page_states.dart';

import '../../common/apis/book_api.dart';
import '../../common/entities/book.dart';
import '../../common/entities/user.dart';
import '../../common/values/colors.dart';
import '../../common/widgets/popMessage.dart';
import '../../global.dart';
import '../search_page/bloc/search_blocs.dart';
import '../search_page/bloc/search_events.dart';
import 'bloc/home_page_blocs.dart';

class HomeController{
  late BuildContext context;

  UserItem? get userProfile => Global.storageService.getUserProfile();

  static final HomeController _singleton = HomeController._internal();

  HomeController._internal();

  //factory constructor, makes sure you have the original only one instance!
  factory HomeController({required BuildContext context}){
    _singleton.context = context;
    return _singleton;
  }

  Future<void> init() async {
    //print("...home controller init method...");
    //make sure that user is logged in, then make an api call
    if (Global.storageService.getUserToken().isNotEmpty){
        var result = await BookAPI.recommendedBookList();
        if(result.code==200){
          //print(result.data);
          if(context.mounted){
            context.read<HomePageBloc>().add(HomePageBookItem(result.data!));
            return;
          }
        }else{
          print(result.code);
          return;
        }
    }
    else{
      print("user has alrd logged out");
    }
    //return;
  }

  Future<void> asyncRandomBookList() async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(
            backgroundColor: AppColors.greyBackground, color: AppColors.warmPink),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true
    );
    var result = await BookAPI.bookList();
    if(result.code==200){
      if(context.mounted) {
        context.read<HomePageBloc>().add(HomePageBookItem(result.data!));
        EasyLoading.dismiss();
        return;
      }
    }else{
      popMessage(message: 'Internet error');
    }
  }

  Future<void> asyncNewBookList() async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(
            backgroundColor: AppColors.greyBackground, color: AppColors.warmPink),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true
    );
    var result = await BookAPI.newBookList();
    if(result.code==200){
      if(context.mounted) {
        context.read<HomePageBloc>().add(HomePageBookItem(result.data!));
        EasyLoading.dismiss();
        return;
      }
      //print('load data');
    }else{
      popMessage(message: 'Internet error');
    }
  }

  Future<void> asyncEconomicBookList() async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(
            backgroundColor: AppColors.greyBackground, color: AppColors.warmPink),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true
    );
    var result = await BookAPI.fromCheapestList();
    if(result.code==200){
      if(context.mounted) {
        context.read<HomePageBloc>().add(HomePageBookItem(result.data!));
        EasyLoading.dismiss();
        return;
      }
      //print('load data');
    }else{
      popMessage(message: 'Internet error');
    }
  }

  Future<void> asyncLoadSearchData(String item) async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(
            backgroundColor: AppColors.greyBackground, color: AppColors.warmPink),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true
    );
    SearchRequestEntity searchRequestEntity = SearchRequestEntity();
    searchRequestEntity.search = item;
    var result = await BookAPI.searchBook(params: searchRequestEntity);
    if(result.code==200){
      if(context.mounted){
        context.read<HomePageBloc>().add(HomePageBookItem(result.data!));
        EasyLoading.dismiss();
        //print('${jsonEncode(result.data!)}');
      }
    }else{
      popMessage(message: 'Internet error');
    }
  }

  Future<void> asyncPopularBookList() async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(
            backgroundColor: AppColors.greyBackground, color: AppColors.warmPink),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true
    );
    var result = await BookAPI.recommendedBookList();
    if(result.code==200){
      if(context.mounted) {
        context.read<HomePageBloc>().add(HomePageBookItem(result.data!));
        EasyLoading.dismiss();
        return;
      }
    }else{
      popMessage(message: 'Internet error');
    }
  }

}



// switch(bookListIndex){
//   case 0: {
//     var result = await BookAPI.bookList();
//     if(result.code==200){
//       //print(result.data);
//       if(context.mounted){
//         context1.add(HomePageBookItem(result.data!));
//       }
//     }else{
//       print(result.code);
//       //return;
//     }
//   }
//   break;
//
//   case 1: {
//     var result1 = await BookAPI.recommendedBookList();
//     if(result1.code==200){
//       //print(result.data);
//       if(context.mounted){
//         context1.add(HomePageBookItem(result1.data!));
//       }
//     }else{
//       print(result1.code);
//       //return;
//     }
//   }
//   break;
//
//   case 2:{
//     var result = await BookAPI.bookList();
//     if(result.code==200){
//       //print(result.data);
//       if(context.mounted){
//         context1.add(HomePageBookItem(result.data!));
//       }
//     }else{
//       print(result.code);
//       //return;
//     }
//   }
//   break;
//
//   default: {
//     var result = await BookAPI.bookList();
//     if(result.code==200){
//       //print(result.data);
//       if(context.mounted){
//         context1.add(HomePageBookItem(result.data!));
//       }
//     }else{
//       print(result.code);
//       //return;
//     }
//   }
//   break;
// }