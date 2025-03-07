import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/apis/book_api.dart';
import 'bloc/my_books_blocs.dart';
import 'bloc/my_books_events.dart';

class MyBooksController{
  late BuildContext context;
  MyBooksController({required this.context});


  //after the context is ready this init() method gets called
  void init(){
    asyncLoadMyBooksData();
  }

  asyncLoadMyBooksData() async {

    context.read<MyBooksBloc>().add(const TriggerLoadingMyBooksEvent());
    var result = await BookAPI.booksBought();
    if(result.code==200){
      if(context.mounted){
        //save data to shared storage
        context.read<MyBooksBloc>().add(const TriggerDoneLoadingMyBooksEvent());

        Future.delayed(const Duration(milliseconds: 10), (){
          context.read<MyBooksBloc>().add(TriggerLoadedMyBooksEvent(result.data!));

        });
      }
    }
  }
}