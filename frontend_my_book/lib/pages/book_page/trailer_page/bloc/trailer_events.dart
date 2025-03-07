import '../../../../common/entities/book.dart';
import '../../../../common/entities/chapter.dart';

abstract class TrailerEvent{
  const TrailerEvent();
}

class TriggerTrailerMedia extends TrailerEvent{
  const TriggerTrailerMedia(this.trailerMediaItem);
  final List<TrailerMediaItem> trailerMediaItem;
}

class TriggerChapterList extends TrailerEvent{
  const TriggerChapterList(this.chapterListItem):super();
  final List<ChapterListItem> chapterListItem;
}

class TriggerUrlItem extends TrailerEvent{
  final Future<void>? initMediaPlayerFuture;
  const TriggerUrlItem(this.initMediaPlayerFuture);
}

class TriggerPlay extends TrailerEvent{
  final bool isPlay;
  const TriggerPlay(this.isPlay);
}

class TriggerCheckBuyChapter extends TrailerEvent{
  const TriggerCheckBuyChapter(this.checkBuy):super();
  final bool checkBuy;
}

// class TriggerMediaIndex extends MediaEvent{
//   final int mediaIndex;
//   const TriggerMediaIndex(this.mediaIndex);
//   @override
//   List<Object?> get props => [mediaIndex];
// }