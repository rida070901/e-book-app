import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/entities/book.dart';
import 'author_profile_states.dart';

class AuthorProfileCubits extends Cubit<AuthorProfileStates>{
  AuthorProfileCubits():super(const AuthorProfileStates());

  triggerAuthorProfile(AuthorItem event){
    emit(state.copyWith(authorItem:event));
  }

  triggerBookItemChange(List<BookItem> event){
    emit(state.copyWith(bookItem:event));
  }
}