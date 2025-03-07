import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/pages/book_page/author_profile_page/cubit/author_prodile_cubits.dart';
import 'package:my_book/pages/book_page/chapter_page/bloc/chapter_blocs.dart';
import 'package:my_book/pages/messages_page/chat_list_page/cubits/chat_list_cubits.dart';
import 'package:my_book/pages/profile_page/payment_details_page/cubit/payment_details_cubits.dart';
import 'package:my_book/pages/search_page/bloc/search_blocs.dart';
import 'package:my_book/pages/welcome_page/bloc/welcome_blocs.dart';
import '../application_start_page/bloc/app_start_page_blocs.dart';
import '../book_page/bloc/book_blocs.dart';
import '../book_page/book_details_page/bloc/book_details_blocs.dart';
import '../book_page/checkout_page/bloc/checkout_blocs.dart';
import '../book_page/trailer_page/bloc/trailer_blocs.dart';
import '../home_page/bloc/home_page_blocs.dart';
import '../messages_page/chat_page/bloc/chat_blocs.dart';
import '../profile_page/about_us_page/bloc/about_us_bloc.dart';
import '../profile_page/bloc/profile_blocs.dart';
import '../profile_page/contact_us_page/bloc/contact_us_bloc.dart';
import '../profile_page/favorites_page/bloc/favorites_blocs.dart';
import '../profile_page/my_books_page/bloc/my_books_blocs.dart';
import '../profile_page/settings_page/bloc/settings_blocs.dart';
import '../sign_in_page/bloc/sign_in_blocs.dart';
import '../sign_up_page/bloc/sign_up_blocs.dart';

class AppBlocProviders{
  static get allBlocProviders => [
    BlocProvider(lazy:false, create: (context) => WelcomeBloc()),
    BlocProvider(create: (context) => SignInBloc()),
    BlocProvider(create: (context) => SignUpBloc()),
    BlocProvider(create: (context) => AppBloc()),
    BlocProvider(create: (context) => HomePageBloc()),
    BlocProvider(create: (context) => SettingsBloc()),
    BlocProvider(create: (context) => BookBloc()),
    BlocProvider(create: (context) => BookDetailsBloc()),
    BlocProvider(create: (context) => CheckoutBloc()),
    BlocProvider(create: (context) => TrailerBloc()),
    BlocProvider(create: (context) => ChapterBloc()),
    BlocProvider(create: (context) => ProfileBloc()),
    BlocProvider(create: (context) => FavoritesBloc()),
    BlocProvider(create: (context) => MyBooksBloc()),
    BlocProvider(create: (context) => PaymentDetailCubits()),
    BlocProvider(create: (context) => SearchBloc()),
    BlocProvider(create: (context) => AuthorProfileCubits()),
    BlocProvider(create: (context) => ChatBloc()),
    BlocProvider(create: (context) => ChatListCubit()),
    BlocProvider(create: (context) => AboutUsBloc()),
    BlocProvider(create: (context) => ContactUsBloc()),
  ];
}