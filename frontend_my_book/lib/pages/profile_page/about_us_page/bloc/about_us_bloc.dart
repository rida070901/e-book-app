import 'package:flutter_bloc/flutter_bloc.dart';

import 'about_us_event.dart';
import 'about_us_state.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState>{
  AboutUsBloc():super(AboutUsState());

}