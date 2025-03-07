import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_book/common/entities/book.dart';
import 'package:my_book/common/routes/route_names.dart';
import 'package:my_book/common/widgets/popMessage.dart';
import 'package:my_book/pages/book_page/book_details_page/bloc/book_details_blocs.dart';
import 'package:my_book/pages/book_page/book_details_page/bloc/book_details_events.dart';
import '../../../common/apis/book_api.dart';
import '../../../common/apis/chapter_api.dart';
import '../../../common/entities/chapter.dart';
import '../../../common/values/colors.dart';
import '../trailer_page/bloc/trailer_blocs.dart';
import '../trailer_page/bloc/trailer_events.dart';

class BookDetailsController{
  final BuildContext context;

  BookDetailsController({required this.context});

  void init() async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    asyncLoadBookData(args["id"]);
    asyncLoadChapterData(args["id"]);
    asyncLoadBookBought(args["id"]);
    checkFavorite(args["id"]);
  }

  asyncLoadBookData(int? id) async {
    BookRequestEntity bookRequestEntity = BookRequestEntity();
    bookRequestEntity.id = id;
    var result = await BookAPI.bookDetails(params: bookRequestEntity); //load data
    if(result.code==200){
      if(context.mounted){
        context.read<BookDetailsBloc>().add(TriggerBookDetailsEvent(result.data!));
      }
    }else{
      popMessage(message: "Something went wrong");
      //print("---------Error code is: ${result.code}---------");
    }
  }

  asyncLoadChapterData(int? id) async {
    ChapterRequestEntity chapterRequestEntity = ChapterRequestEntity();
    chapterRequestEntity.id = id;
    var result = await ChapterAPI.chapterList(params: chapterRequestEntity);
    if(result.code==200){
      if(context.mounted){
        context.read<BookDetailsBloc>().add(TriggerChapterListEvent(result.data!));
      }
    }else{
      popMessage(message: "Something went wrong");
      print("---------Error code is: ${result.code}---------");
    }
  }

  Future<void> buyButton(int? id) async {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(
        backgroundColor: AppColors.greyBackground, color: AppColors.warmPink),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );
    BookRequestEntity bookRequestEntity = BookRequestEntity();
    bookRequestEntity.id = id;
    var result = await BookAPI.bookPay(params: bookRequestEntity);
    EasyLoading.dismiss();

    if(result.code==200){
      var url = Uri.decodeFull(result.data!); //cleaner format of url
      if(context.mounted){
        var res = await Navigator.of(context).pushNamed(AppRoutes.CHECKOUT, arguments: {"url": url});

        if(res=="success"){
          popMessage(message: "You bought it successfully");
        }
        //print("--------my returned stripe url is $url}");
      }
    }else{
      popMessage(message: result.msg!);
      print("----------failed payment----------");
    }
  }

  Future<void> asyncLoadBookBought(int? id) async {

    BookRequestEntity bookRequestEntity = BookRequestEntity();
    bookRequestEntity.id = id;
    var result = await BookAPI.bookBought(params: bookRequestEntity);

    if(result.code==200){
      if(result.msg=="success"){
        // item is bought
        if(context.mounted){
          context.read<BookDetailsBloc>().add(const TriggerCheckBuy(true));
          context.read<TrailerBloc>().add(const TriggerCheckBuyChapter(true));
        }
      }else{
        // item is not bought
        if(context.mounted){
          context.read<BookDetailsBloc>().add(const TriggerCheckBuy(false));
          context.read<TrailerBloc>().add(const TriggerCheckBuyChapter(false));
        }
      }
    }
  }

  checkFavorite(int? id) async {
    BookRequestEntity bookRequestEntity = BookRequestEntity();
    bookRequestEntity.id = id;
    var result = await BookAPI.checkFavorite(params: bookRequestEntity); //load data
    //print("-------------${result.data}");
    if(result.code==200){
      if(context.mounted){
        //print("----------------context is available----------------");
        context.read<BookDetailsBloc>().add(UpdateFavoriteStatus(result.data));
        //print("-------------${result.data}");
      }else{
        //print("----------------context not available----------------");
      }
    }else{
      popMessage(message: "Something went wrong");
      print("---------Error code is: ${result.code}---------");
    }
  }

  addFavorite(int? id) async {
    BookRequestEntity bookRequestEntity = BookRequestEntity();
    bookRequestEntity.id = id;
    var result = await BookAPI.addFavorite(params: bookRequestEntity); //load data
    print("-------------${result.data}");
    if(result.code==200){
      if(context.mounted){
        context.read<BookDetailsBloc>().add(UpdateFavoriteStatus(result.data!));
        print("-------------${result.data}");
      }
    }else{
      popMessage(message: "Something went wrong");
      print("---------Error code is: ${result.code}---------");
    }
  }

  updateFavorite(int? id) async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(
            backgroundColor: AppColors.greyBackground, color: AppColors.warmPink),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true
    );
    BookRequestEntity bookRequestEntity = BookRequestEntity();
    bookRequestEntity.id = id;
    var result = await BookAPI.updateFavorite(params: bookRequestEntity); //load data
    if(result.code==200){
      if(context.mounted){
        context.read<BookDetailsBloc>().add(UpdateFavoriteStatus(result.data!));
        EasyLoading.dismiss();
      }
    }else{
      popMessage(message: "Something went wrong");
      print("---------Error code is: ${result.code}---------");
    }
  }

}

