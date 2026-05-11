import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/routes/routes.dart';
import 'package:news_app/config/theme/dark_theme.dart';
import 'package:news_app/config/theme/light_theme.dart';
import 'package:news_app/daily_news/presentation/bloc/remote/article_bloc.dart';
import 'package:news_app/daily_news/presentation/bloc/remote/article_event.dart';
import 'package:news_app/daily_news/presentation/pages/home/daily_news.dart';
import 'package:news_app/injection_container.dart';

import 'daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'daily_news/presentation/bloc/local/theme_bloc.dart';
import 'daily_news/presentation/bloc/local/theme_event.dart';
import 'daily_news/presentation/bloc/local/theme_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initiallizeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        BlocProvider(
          create: (context) => sl<ThemeBloc>()..add(LoadThemeEvent()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            themeAnimationDuration: Duration(milliseconds: 200),
            home: const DailyNews(),
          );
        },
      ),
    );
  }
}
