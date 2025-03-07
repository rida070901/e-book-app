import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/common/widgets/popMessage.dart';
import '../../common/apis/book_api.dart';
import '../../common/entities/book.dart';
import 'bloc/search_blocs.dart';
import 'bloc/search_events.dart';

class MySearchController{
  late BuildContext context;
  MySearchController({required this.context});

  void init(){
    asyncLoadRecommendedData();
  }

  Future<void> asyncLoadRecommendedData() async {
    var result = await BookAPI.recommendedBookList();
    if(result.code==200){
      if(context.mounted){
        context.read<SearchBloc>().add(TriggerSearchEvent(result.data!));
        //print('load data');
      }
    }else{
      popMessage(message: 'Internet error');
    }
  }


  Future<void> asyncLoadSearchData(String item) async {
    SearchRequestEntity searchRequestEntity = SearchRequestEntity();
    searchRequestEntity.search = item;
    var result = await BookAPI.searchBook(params: searchRequestEntity);
    if(result.code==200){
      if(context.mounted){
        context.read<SearchBloc>().add(TriggerSearchEvent(result.data!));
        //print('${jsonEncode(result.data!)}');
      }
    }else{
      popMessage(message: 'Internet error');
    }
  }


}