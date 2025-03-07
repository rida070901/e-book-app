import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/common/widgets/base_text_widget.dart';
import 'package:my_book/pages/book_page/book_details_page/book_details_controller.dart';

import '../../../common/values/colors.dart';
import 'book_details_page_widgets.dart';
import 'bloc/book_details_blocs.dart';
import 'bloc/book_details_states.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  late BookDetailsController _bookDetailsController;

  @override
  void initState(){
    super.initState();
  }

  @override
  void didChangeDependencies(){ // when the context is ready this gets called and
    super.didChangeDependencies(); // you can pass context around classes as you need
    _bookDetailsController = BookDetailsController(context: context);
    _bookDetailsController.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsBloc, BookDetailsState>(
      builder: (context, state){
        //print("my item here ${state.bookItem?.name}");
        //build thirret i pari, context me data nga api nuk esh ready yet, -> bejm conditional check
        return state.bookItem==null ?
          const Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.greyBackground,
              color: AppColors.warmPink,
            ))
            :Container(
            color: Colors.white,
            child: SafeArea(
                child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(title: const Text("Book Details", style: TextStyle(color: AppColors.blackText, fontWeight: FontWeight.bold))),
                    body: SingleChildScrollView(
                        child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        thumbnail(state.bookItem!.thumbnail.toString()),
                                        SizedBox(height: 15.h),
                                        menuView(context, state, _bookDetailsController),
                                        SizedBox(height: 15.h),
                                        reusableText("Book Description"),
                                        SizedBox(height: 15.h),
                                        descriptionText(state.bookItem!.description.toString()),
                                        SizedBox(height: 20.h),
                                        GestureDetector(
                                          onTap: (){
                                            _bookDetailsController.buyButton(state.bookItem!.id);
                                          },
                                          child: reusableButton("Buy Now"),
                                        ),
                                        SizedBox(height: 20.h),
                                        reusableText("About this book:", fontSize: 14.sp),
                                        bookDetails(context, state),
                                        SizedBox(height: 25.h),
                                        reusableText("Book Trailer:"),
                                        SizedBox(height: 15.h),
                                        trailerMenu(state),
                                        SizedBox(height: 20.h),
                                        reusableText("Chapters:"),
                                        SizedBox(height: 15.h),
                                        chaptersListMenu(state),
                                      ]
                                  )
                              )
                            ]
                        )
                    )
                )
            )
        );
      }
    );
  }
}
