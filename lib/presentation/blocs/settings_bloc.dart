import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object?> get props => [];
}

class ToggleThemeEvent extends SettingsEvent {}

class SettingsState extends Equatable {
  final bool isDark;
  const SettingsState(this.isDark);

  @override
  List<Object?> get props => [isDark];
}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState(false)) {
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  void _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<SettingsState> emit,
  ) {
    emit(SettingsState(!state.isDark));
  }
}
