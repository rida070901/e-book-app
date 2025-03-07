import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/base_text_widget.dart';
import 'bloc/my_books_blocs.dart';
import 'bloc/my_books_states.dart';
import 'my_books_controller.dart';
import 'my_books_widgets.dart';

class MyBooks extends StatefulWidget {
  const MyBooks({super.key});

  @override
  State<MyBooks> createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  late MyBooksController _myBooksController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _myBooksController = MyBooksController(context: context);
    _myBooksController.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBooksBloc, MyBooksState>(
      builder: (context, state){
        if(state is DoneLoadingMyBooksState){
          if (kDebugMode) {
            print('done loading the data we bought....');
          }
          return Container();
        }else if(state is LoadedMyBooksState){
          if(state.bookItem.isEmpty){
            if (kDebugMode) {
              print('bang........');
            }
          }
          if (kDebugMode) {
            print('just loaded the data we bought.....');
          }
          return Scaffold(
            appBar: buildAppBar("My Books"),
            body:  Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.sp),
              child:SingleChildScrollView(
                child: Column(
                  children: [
                    //menuView(),
                    imageView(),
                    buildBoughtBooksList(state),
                  ],
                ),
              ),
            ),
          );
        }else if(state is LoadingMyBooksState){
          if (kDebugMode) {
            print('loading the data we bought......');
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
