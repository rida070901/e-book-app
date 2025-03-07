import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/common/routes/route_names.dart';
import 'package:my_book/pages/book_page/author_profile_page/author_profile.dart';
import 'package:my_book/pages/book_page/author_profile_page/cubit/author_prodile_cubits.dart';
import 'package:my_book/pages/book_page/chapter_page/bloc/chapter_blocs.dart';
import 'package:my_book/pages/book_page/checkout_page/bloc/checkout_blocs.dart';
import 'package:my_book/pages/book_page/trailer_page/bloc/trailer_blocs.dart';
import 'package:my_book/pages/profile_page/favorites_page/favorites.dart';
import 'package:my_book/pages/profile_page/payment_details_page/cubit/payment_details_cubits.dart';
import 'package:my_book/pages/profile_page/payment_details_page/payment_details.dart';
import '../../global.dart';
import '../../pages/application_start_page/app_start_page.dart';
import '../../pages/application_start_page/bloc/app_start_page_blocs.dart';
import '../../pages/book_page/book_details_page/bloc/book_details_blocs.dart';
import '../../pages/book_page/book_details_page/book_details_page.dart';
import '../../pages/book_page/chapter_page/chapter.dart';
import '../../pages/book_page/checkout_page/checkout.dart';
import '../../pages/book_page/trailer_page/trailer_details.dart';
import '../../pages/home_page/bloc/home_page_blocs.dart';
import '../../pages/home_page/home_page.dart';
import '../../pages/messages_page/chat_page/bloc/chat_blocs.dart';
import '../../pages/messages_page/chat_page/chat.dart';
import '../../pages/profile_page/about_us_page/about_us.dart';
import '../../pages/profile_page/about_us_page/bloc/about_us_bloc.dart';
import '../../pages/profile_page/bloc/profile_blocs.dart';
import '../../pages/profile_page/contact_us_page/bloc/contact_us_bloc.dart';
import '../../pages/profile_page/contact_us_page/contact_us.dart';
import '../../pages/profile_page/favorites_page/bloc/favorites_blocs.dart';
import '../../pages/profile_page/my_books_page/bloc/my_books_blocs.dart';
import '../../pages/profile_page/my_books_page/my_books.dart';
import '../../pages/profile_page/profile.dart';
import '../../pages/profile_page/settings_page/bloc/settings_blocs.dart';
import '../../pages/profile_page/settings_page/settings.dart';
import '../../pages/sign_in_page/bloc/sign_in_blocs.dart';
import '../../pages/sign_in_page/sign_in.dart';
import '../../pages/sign_up_page/bloc/sign_up_blocs.dart';
import '../../pages/sign_up_page/sign_up.dart';
import '../../pages/welcome_page/bloc/welcome_blocs.dart';
import '../../pages/welcome_page/welcome.dart';

class AppPages {
  static List<PageEntity> routes(){
    return [
      PageEntity(
          route: AppRoutes.WELCOME,
          page: const Welcome(),
          bloc: BlocProvider(create: (_) => WelcomeBloc(),)
      ),
      PageEntity(
          route: AppRoutes.SIGN_IN,
          page: const SignIn(),
          bloc: BlocProvider(create: (_) => SignInBloc(),)
      ),
      PageEntity(
          route: AppRoutes.SIGN_UP,
          page: const SignUp(),
          bloc: BlocProvider(create: (_) => SignUpBloc(),)
      ),
      PageEntity(
          route: AppRoutes.APP_START_PAGE,
          page: const AppStartPage(),
          bloc: BlocProvider(create: (_) => AppBloc(),)
      ),
      PageEntity(
          route: AppRoutes.HOME_PAGE,
          page: const HomePage(),
          bloc: BlocProvider(create: (_) => HomePageBloc(),)
      ),
      PageEntity(
          route: AppRoutes.SETTINGS,
          page: const Settings(),
          bloc: BlocProvider(create: (_) => SettingsBloc(),)
      ),
      PageEntity(
          route: AppRoutes.BOOK_DETAILS,
          page: const BookDetails(),
          bloc: BlocProvider(create: (_) => BookDetailsBloc(),)
      ),
      PageEntity(
          route: AppRoutes.TRAILER_DETAILS,
          page: const TrailerDetails(),
          bloc: BlocProvider(create: (_) => TrailerBloc(),)
      ),
      PageEntity(
          route: AppRoutes.CHAPTER,
          page: const ChapterPage(),
          bloc: BlocProvider(create: (_) => ChapterBloc(),)
      ),
      PageEntity(
          route: AppRoutes.CHECKOUT,
          page: const Checkout(),
          bloc: BlocProvider(create: (_) => CheckoutBloc(),)
      ),
      PageEntity(
          route: AppRoutes.PROFILE,
          page: const Profile(),
          bloc: BlocProvider(create: (_) => ProfileBloc(),)
      ),
      PageEntity(
          route: AppRoutes.MY_BOOKS,
          page: const MyBooks(),
          bloc: BlocProvider(create: (_) => MyBooksBloc(),)
      ),
      PageEntity(
          route: AppRoutes.PAYMENT_DETAILS,
          page: const PaymentDetails(),
          bloc: BlocProvider(create: (_) => PaymentDetailCubits(),)
      ),
      PageEntity(
          route: AppRoutes.AUTHOR_PROFILE,
          page: const AuthorProfile(),
          bloc: BlocProvider(create: (_) => AuthorProfileCubits(),)
      ),
      PageEntity(
          route: AppRoutes.CHAT_PAGE,
          page: const Chat(),
          bloc: BlocProvider(create: (_) => ChatBloc(),)
      ),
      PageEntity(
          route: AppRoutes.FAVORITES,
          page: const Favorites(),
          bloc: BlocProvider(create: (_) => FavoritesBloc(),)
      ),
      PageEntity(
          route: AppRoutes.ABOUT_US,
          page: const AboutUs(),
          bloc: BlocProvider(create: (_) => AboutUsBloc(),)
      ),
      PageEntity(
          route: AppRoutes.CONTACT_US,
          page: const ContactUs(),
          bloc: BlocProvider(create: (_) => ContactUsBloc(),)
      ),
    ];
  }

  //return all the bloc providers
  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()){
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }

  // a modal that covers entire screen as we click on navigator object
  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings){
    if(settings.name!=null){
      //check for route name matching when Navigator gets triggered.
      var result = routes().where((element) => element.route==settings.name);
      if(result.isNotEmpty){
        //print("valid route name ${settings.name}");
        bool deviceFirstOpen  = Global.storageService.getDeviceFirstOpen();
        if(result.first.route==AppRoutes.WELCOME&&deviceFirstOpen){
          bool isLoggedIn = Global.storageService.getIsLoggedIn();
          if(isLoggedIn){
            return MaterialPageRoute(builder: (_)=>const AppStartPage(), settings: settings);
          }
          return MaterialPageRoute(builder: (_)=>const SignIn(), settings: settings);
        }
        return MaterialPageRoute(builder: (_)=>result.first.page, settings:settings);
      }
    }
    //print("invalid route name ${settings.name}");
    return MaterialPageRoute(builder: (_)=>const SignIn(), settings: settings);
  }
}

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route,  required this.page,  this.bloc});
}