import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_book/pages/book_page/chapter_page/bloc/chapter_events.dart';

import '../../../common/apis/chapter_api.dart';
import '../../../common/entities/chapter.dart';
import '../../../common/routes/route_names.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/popMessage.dart';
import 'bloc/chapter_blocs.dart';

class ChapterController{
  final BuildContext context;

  ChapterController({required this.context});

  void init() async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    //asyncLoadChapterDetailsData(args["id"]);
    asyncLoadChaptersData(args["clicked_chapter_id"], args["chapter_list"]);
  }

  asyncLoadChaptersData(int? clicked_chapter_id, List<ChapterListItem> chapterList) async {
      if(context.mounted){
        print("----------------context is available----------------");
        // ChapterDetailItem chapterDetailItem = ChapterDetailItem();
        // chapterDetailItem.id = clicked_chapter_id;
        // chapterDetailItem.name = name;
        // chapterDetailItem.title = title;
        // chapterDetailItem.subtitle = subtitle;
        // chapterDetailItem.text = text;

        List<ChapterListItem> chapterListItem = chapterList;

        ChapterDetailItem chapterDetailItem1 = ChapterDetailItem();
        chapterDetailItem1.id = clicked_chapter_id;

        for(ChapterListItem item in chapterListItem){
          if(item.id == clicked_chapter_id){
            ChapterDetailItem chapterDetailItem = ChapterDetailItem();
            chapterDetailItem.id = clicked_chapter_id;
            chapterDetailItem.name = item.name;
            chapterDetailItem.title = item.title;
            chapterDetailItem.subtitle = item.subtitle;
            chapterDetailItem.text = item.text;
            context.read<ChapterBloc>().add(TriggerChapterDetailsEvent(chapterDetailItem));

          }else if(clicked_chapter_id==(chapterListItem.length+1)) {
            popMessage(message: "This is the last chapter");
            return;
          }
        }

        //context.read<ChapterBloc>().add(TriggerChapterDetailsEvent(chapterDetailItem));
        context.read<ChapterBloc>().add(TriggerChapterListEvents(chapterListItem));

        // print("${chapterListItem[1]!.id}");
        // print("${chapterListItem[1]!.name}");
        //print("----------my edition data is ${result.data![0].name}-----------");
      }else{
        print("----------------context not available----------------");
      }
  }

  // Future<void> nextChapterButton(int? id) async {
  //   EasyLoading.show(
  //       indicator: const CircularProgressIndicator(
  //           backgroundColor: AppColors.greyBackground,
  //           color: AppColors.warmPink),
  //       maskType: EasyLoadingMaskType.clear,
  //       dismissOnTap: true
  //   );
  //
  //   EasyLoading.dismiss();
  //
  //     if (context.mounted) {
  //       await asyncLoadChaptersData(args["clicked_chapter_id"], args["chapter_list"]);
  //     }
  // }



  }

  // asyncLoadChapterDetailsData(int? id) async {
  //   ChapterRequestEntity chapterRequestEntity = ChapterRequestEntity();
  //   chapterRequestEntity.id = id;
  //   var result = await ChapterAPI.chapterDetails(params: chapterRequestEntity);
  //   // print("----------my edition data is ${result.data?.toString()}-----------");
  //   if(result.code==200){
  //     if(context.mounted){
  //       print("----------------context is available----------------");
  //       context.read<ChapterBloc>().add(TriggerChapterDetailsEvent(result.data!));
  //       //print("----------my edition data is ${result.data![0].name}-----------");
  //     }else{
  //       print("----------------context not available----------------");
  //     }
  //   }else{
  //     popMessage(message: "Something went wrong");
  //     print("---------Error code is: ${result.code}---------");
  //   }
  // }

