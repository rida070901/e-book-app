import '../../../../common/entities/book.dart';
import '../../../../common/entities/chapter.dart';

class TrailerState{
  final List<TrailerMediaItem> trailerMediaItem;
  final List<ChapterListItem> chapterListItem;
  final Future<void>? initializeMediaPlayerFuture;
  final bool isPlay;
  final bool? checkBuy;
  //final int mediaIndex;

  const TrailerState(
      {this.trailerMediaItem = const <TrailerMediaItem>[],
        this.chapterListItem = const <ChapterListItem>[],
        this.isPlay = false,
        this.initializeMediaPlayerFuture,
        this.checkBuy=false
        //this.mediaIndex=0
      });

  TrailerState copyWith(
      {List<TrailerMediaItem>? trailerMediaItem,
        List<ChapterListItem>? chapterListItem,
        bool? isPlay,
        Future<void>? initializeMediaPlayerFuture,
        bool? checkBuy,
        //int? mediaIndex
      }) {
    return TrailerState(
        trailerMediaItem: trailerMediaItem ?? this.trailerMediaItem,
        chapterListItem: chapterListItem ?? this.chapterListItem,
        isPlay: isPlay ?? this.isPlay,
        initializeMediaPlayerFuture:
        initializeMediaPlayerFuture ?? this.initializeMediaPlayerFuture,
        checkBuy: checkBuy ?? this.checkBuy,

      //mediaIndex: mediaIndex??this.mediaIndex
    );
  }

  // @override
  // List<Object?> get props => [editionMediaItem, initializeMediaPlayerFuture, isPlay, mediaIndex];
}
