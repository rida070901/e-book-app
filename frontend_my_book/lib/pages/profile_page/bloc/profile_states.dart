import '../../../common/entities/user.dart';

class ProfileState{
  final UserItem? userProfile;
  const ProfileState({this.userProfile});

  ProfileState copyWith({UserItem? userProfile}){
    return ProfileState(userProfile: userProfile??this.userProfile);
  }
}