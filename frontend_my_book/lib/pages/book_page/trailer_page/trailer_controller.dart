import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/common/entities/book.dart';
import 'package:video_player/video_player.dart';
import '../../../common/apis/book_api.dart';
import '../../../common/apis/chapter_api.dart';
import '../../../common/entities/chapter.dart';
import '../../../common/widgets/popMessage.dart';
import '../book_details_page/bloc/book_details_blocs.dart';
import '../book_details_page/bloc/book_details_events.dart';
import 'bloc/trailer_blocs.dart';
import 'bloc/trailer_events.dart';

class TrailerController {
  final BuildContext context;
  VideoPlayerController? videoPlayerController;

  TrailerController({required this.context});

  //when click the video pass the edition id
  void init() async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    //set the earlier video to false means, stop playing
    context.read<TrailerBloc>().add(const TriggerPlay(false));
    await asyncLoadTrailerData(args['id']);
    await asyncLoadChapterData(args['id']);
  }

  asyncLoadChapterData(int? id) async {
    ChapterRequestEntity chapterRequestEntity = ChapterRequestEntity();
    chapterRequestEntity.id = id;
    var result = await ChapterAPI.chapterList(params: chapterRequestEntity);
    // print("----------my edition data is ${result.data?.toString()}-----------");
    if(result.code==200){
      if(context.mounted){
        //print("----------------context is available----------------");
        context.read<TrailerBloc>().add(TriggerChapterList(result.data!));
        //print("----------my edition data is ${result.data![0].name}-----------");
      }else{
        //print("----------------context not available----------------");
      }
    }else{
      popMessage(message: "Something went wrong");
      //print("---------Error code is: ${result.code}---------");
    }
  }

    Future<void> asyncLoadTrailerData(int? id) async {
      BookRequestEntity bookRequestEntity = BookRequestEntity();
      bookRequestEntity.id = id;
      var result = await BookAPI.trailerDetail(params: bookRequestEntity);
      if (result.code == 200) {
        if (context.mounted) {
          context.read<TrailerBloc>().add(TriggerTrailerMedia(result.data!));
          if (result.data!.isNotEmpty) {
            var url = result.data!.elementAt(0).url;
            videoPlayerController =
                VideoPlayerController.networkUrl(Uri.parse(url!));
            var initPlayer = videoPlayerController?.initialize();
            context.read<TrailerBloc>().add(TriggerUrlItem(initPlayer));
          }
        }
      }
    }

    void playVideo(String url) {
      if (videoPlayerController != null) {
        videoPlayerController?.pause();
        videoPlayerController?.dispose();
      }
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url!));
      context.read<TrailerBloc>().add(const TriggerPlay(false));
      context.read<TrailerBloc>().add(const TriggerUrlItem(null));
      var initPlayer = videoPlayerController?.initialize().then((value) {
        videoPlayerController?.seekTo(
            const Duration(milliseconds: 0)); //go to the beginning of the video
      });
      context.read<TrailerBloc>().add(TriggerUrlItem(initPlayer));
      context.read<TrailerBloc>().add(const TriggerPlay(true));

      videoPlayerController?.play(); //autoplay
    }
  }
