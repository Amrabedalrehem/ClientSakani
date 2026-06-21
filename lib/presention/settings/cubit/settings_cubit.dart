import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/data/shared%20prefrence/SettingsService.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(
          isDarkMode: SettingsService.isDarkMode,
          language: SettingsService.language,
        ));

  void toggleDarkMode() {
    final newVal = !state.isDarkMode;
    SettingsService.setDarkMode(newVal);
    emit(state.copyWith(isDarkMode: newVal));
  }

  void setLanguage(String lang) {
    SettingsService.setLanguage(lang);
    emit(state.copyWith(language: lang));
  }
}
