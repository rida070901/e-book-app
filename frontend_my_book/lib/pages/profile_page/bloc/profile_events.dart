import '../../../common/entities/user.dart';

abstract class ProfileEvent{
  const ProfileEvent();
}

class TriggerProfileName extends ProfileEvent{
  final UserItem userProfile;
  const TriggerProfileName(this.userProfile);
}