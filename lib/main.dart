import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_c13_friday/home_screen.dart';
import 'package:news_c13_friday/internet_service.dart';
import 'package:news_c13_friday/model/news_response.dart';
import 'package:news_c13_friday/model/sources_response.dart';

import 'bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  InternetService().init();
  await Hive.initFlutter();
  Hive.registerAdapter(SourcesResponseAdapter());
  Hive.registerAdapter(SourcesAdapter());
  Hive.registerAdapter(NewsResponseAdapter());
  Hive.registerAdapter(ArticlesAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
