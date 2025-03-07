import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/apis/book_api.dart';
import 'bloc/favorites_blocs.dart';
import 'bloc/favorites_events.dart';

class FavoritesController{
  late BuildContext context;
  FavoritesController({required this.context});

  //after the context is ready this init() method gets called
  void init(){
    asyncLoadFavoriteBooksList();
  }

  asyncLoadFavoriteBooksList() async {
    context.read<FavoritesBloc>().add(const TriggerLoadingFavoritesEvent());
    var result = await BookAPI.favoritesList();
    if(result.code==200){
      if(context.mounted){
        //save data to shared storage
        context.read<FavoritesBloc>().add(const TriggerDoneLoadingFavoritesEvent());

        Future.delayed(const Duration(milliseconds: 10), (){
          context.read<FavoritesBloc>().add(TriggerLoadedFavoritesEvent(result.data!));
        });
      }
    }
  }

}