import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/pages/book_page/trailer_page/trailer_controller.dart';
import 'package:video_player/video_player.dart';
import '../../../common/values/colors.dart';
import 'bloc/trailer_blocs.dart';
import 'bloc/trailer_events.dart';
import 'bloc/trailer_states.dart';
import 'trailer_detail_widgets.dart';

class TrailerDetails extends StatefulWidget {
  const TrailerDetails({super.key});

  @override
  State<TrailerDetails> createState() => _EditionDetailsState();
}

class _EditionDetailsState extends State<TrailerDetails> {

  late TrailerController _trailerController;
  //int mediaIndex = 0;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _trailerController = TrailerController(context: context);
    context.read<TrailerBloc>().add(const TriggerUrlItem(null));
    _trailerController.init();
  }

  @override
  void dispose(){
    _trailerController.videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrailerBloc, TrailerState>(builder: (context, state){
      return SafeArea(
        child: Container(
          color: Colors.white,
          child: Scaffold(
            appBar: AppBar(title: const Text("Book Trailer", style: TextStyle(color: AppColors.blackText, fontWeight: FontWeight.bold))),
            body: CustomScrollView(
              slivers: [
                SliverPadding(padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 25.w
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        // ------video preview--------
                        trailerVideoPlayer(state, _trailerController),
                        // ------video buttons--------
                        videoButtons(context, state, _trailerController),
                      ]
                    )
                  )
                ),
                chaptersListMenu(state),
              ]
            )
          )
        )
      );
    },);
  }
}
