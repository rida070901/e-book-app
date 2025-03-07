import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/common/routes/route_names.dart';
import 'package:my_book/common/widgets/base_text_widget.dart';
import 'package:my_book/common/widgets/popMessage.dart';
import 'package:my_book/pages/book_page/chapter_page/chapter_controller.dart';

import '../../../common/values/colors.dart';
import 'bloc/chapter_blocs.dart';
import 'bloc/chapter_states.dart';

class ChapterPage extends StatefulWidget {
  const ChapterPage({super.key});

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  late ChapterController _chapterController;

  @override
  void didChangeDependencies() {
    //when the context is ready this gets called and you can pass context around classes as you need
    super.didChangeDependencies();
    //id = ModalRoute.of(context)!.settings.arguments as Map;
    _chapterController = ChapterController(context: context);
    _chapterController.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChapterBloc, ChapterState>(
      builder: (context, state) {
        return state.chapterDetailItem==null ?
          const Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.greyBackground,
              color: AppColors.warmPink,
            ))
          :Container(
          //print("${state.chapterListItem[0].name}");
          color: Colors.white,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(title: Text("${state.chapterDetailItem?.name}", style: const TextStyle(color: AppColors.blackText, fontWeight: FontWeight.bold))),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: reusableText("${state.chapterDetailItem?.title}", fontSize: 22)),
                            SizedBox(height: 15.h),
                            reusableText("${state.chapterDetailItem?.subtitle}", fontSize: 18, fontWeight: FontWeight.w300),
                            SizedBox(height: 10.h),
                            reusableText("${state.chapterDetailItem?.text}", fontSize: 16, fontWeight: FontWeight.normal),
                            SizedBox(height: 20.h),
                            GestureDetector(
                              onTap: (){
                                // print("${state.chapterDetailItem?.id}");
                                // print("${state.chapterDetailItem?.name}");
                                // Navigator.of(context).pushNamed(AppRoutes.CHAPTER, arguments: {"id": state.chapterDetailItem?.id = (state.chapterDetailItem!.id! + 1)});
                                _chapterController.asyncLoadChaptersData((state.chapterDetailItem!.id! + 1), state.chapterListItem);
                              },
                              child: reusableButton("Next Chapter"),
                            )
                          ],
                        )
                      )
                    ]
                  ),
                ),
              ),
            ),
        );
      },
    );
  }
}
