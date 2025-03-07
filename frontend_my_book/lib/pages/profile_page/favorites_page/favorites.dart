import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/pages/common_widgets.dart';
import '../../../common/values/colors.dart';
import 'bloc/favorites_blocs.dart';
import 'bloc/favorites_states.dart';
import 'favorites_controller.dart';
import 'favorites_widgets.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late FavoritesController _favoritesController;

  @override
  void didChangeDependencies() {
    _favoritesController = FavoritesController(context: context);
    _favoritesController.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state){
          if(state is DoneLoadingFavoritesState){
            if (kDebugMode) {
              print('done loading the favorites list....');
            }
            return Container();
          }else if(state is LoadedFavoritesState){
            if(state.bookItem.isEmpty){
              if (kDebugMode) {
                print('bang........');
              }
            }
            if (kDebugMode) {
              print('just loaded favorites book list.....');
            }
            return Scaffold(
              appBar: buildAppBar("Favorites"),
              body:  Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.sp),
                child:SingleChildScrollView(
                  child: Column(
                    children: [
                      imageView(),
                      SizedBox(height: 15.h),
                      menuView(),
                      buildFavoriteBooksList(state),
                    ],
                  ),
                ),
              ),
            );
          }else if(state is LoadingFavoritesState){
            if (kDebugMode) {
              print('loading favorites data......');
            }
            return const Center(child: CircularProgressIndicator(
                backgroundColor: AppColors.greyBackground,
                color: AppColors.warmPink ));
          }
          return Container();
        }
    );
  }
}
