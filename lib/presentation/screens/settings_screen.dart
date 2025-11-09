import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_map_poi_ui/presentation/blocs/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Налаштування')),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListTile(
            title: const Text('Темна тема', style: TextStyle(fontSize: 20)),
            trailing: Switch(
              value: state.isDark,
              onChanged: (_) =>
                  context.read<SettingsBloc>().add(ToggleThemeEvent()),
            ),
          );
        },
      ),
    );
  }
}
