import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/common/service/service_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'common/routes/bloc_observer.dart';

class Global{
  static late StorageService storageService;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = MyGlobalObserver();
    await Firebase.initializeApp();
    storageService = await StorageService().init();
  }
}