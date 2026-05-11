import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/daily_news/presentation/bloc/local/theme_bloc.dart';
import 'package:news_app/daily_news/presentation/bloc/local/theme_event.dart';
import 'package:news_app/daily_news/presentation/bloc/local/theme_state.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeBloc, ThemeState, bool>(
      selector: (state) => state.isDarkMode,
      builder: (context, isDarkMode) {
        return Switch.adaptive(
          value: isDarkMode,
          onChanged: (value) {
            context.read<ThemeBloc>().add(
                  ToggleThemeEvent(value),
                );
          },
        );
      },
    );
  }
}
