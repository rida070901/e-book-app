import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/welcome_blocs.dart';

class AppBlocProviders{
  static get allBlocProviders => [
    BlocProvider(lazy:false, create: (context) => WelcomeBloc()),
    //BlocProvider(create: (context) => SignInBloc()),
  ];
}