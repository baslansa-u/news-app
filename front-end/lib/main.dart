import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/routes/routes.dart';
import 'package:news_app/config/theme/app_themes.dart';
import 'package:news_app/daily_news/presentation/bloc/remote/article_bloc.dart';
import 'package:news_app/daily_news/presentation/bloc/remote/article_event.dart';
import 'package:news_app/daily_news/presentation/pages/home/daily_news.dart';
import 'package:news_app/injection_container.dart';

import 'daily_news/presentation/bloc/local/local_article_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initiallizeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticlesBloc>(
          create: (context) => sl()..add(GetArticles()),
        ),
        BlocProvider<LocalArticleBloc>(
          create: (context) => sl(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: theme(),
        home: DailyNews(),
      ),
    );
  }
}
