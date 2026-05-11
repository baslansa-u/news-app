import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/daily_news/presentation/bloc/local/theme_event.dart';
import 'package:news_app/daily_news/presentation/bloc/local/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(false)) {
    on<LoadThemeEvent>(_load);
    on<ToggleThemeEvent>(_toggle);
  }

  SharedPreferences? _prefs;

  Future<void> _load(LoadThemeEvent event, Emitter<ThemeState> emit) async {
    _prefs = await SharedPreferences.getInstance();

    final isDark = _prefs?.getBool('isDarkMode') ?? false;

    emit(ThemeState(isDark));
  }

  Future<void> _toggle(ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    emit(ThemeState(event.isDarkMode));

    await _prefs?.setBool('isDarkMode', event.isDarkMode);
  }
}
