import 'package:flutter_bloc/flutter_bloc.dart';
import 'contact_us_event.dart';
import 'contact_us_state.dart';


class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState>{
  ContactUsBloc():super(ContactUsState());

}