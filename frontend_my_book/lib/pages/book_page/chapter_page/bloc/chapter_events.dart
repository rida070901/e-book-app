import '../../../../common/entities/chapter.dart';

abstract class ChapterEvent{
  const ChapterEvent();
}

class TriggerChapterDetailsEvent extends ChapterEvent{
  const TriggerChapterDetailsEvent(this.chapterDetailItem):super();
  final ChapterDetailItem chapterDetailItem;
}

class TriggerChapterListEvents extends ChapterEvent{
  const TriggerChapterListEvents(this.chapterListItem):super();
  final List<ChapterListItem> chapterListItem;
}