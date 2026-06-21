part of 'settings_cubit.dart';

class SettingsState {
  final bool isDarkMode;
  final String language;

  const SettingsState({
    required this.isDarkMode,
    required this.language,
  });

  SettingsState copyWith({
    bool? isDarkMode,
    String? language,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
    );
  }
}
