import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_map_poi_ui/data/datasources/poi_data_source.dart';
import 'package:test_map_poi_ui/data/repositories/poi_dao_repository_impl.dart';
import 'package:test_map_poi_ui/presentation/blocs/map_bloc.dart';
import 'package:test_map_poi_ui/presentation/blocs/settings_bloc.dart';
import 'package:test_map_poi_ui/presentation/screens/map_screen.dart';
import 'package:test_map_poi_ui/presentation/screens/settings_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              MapBloc(PoiDaoRepositoryImpl(PoiDaoDataSourceImpl()))
                ..add(
                  MapLoadPoiEvent(),
                ),
        ),
        BlocProvider(
          create: (context) => SettingsBloc(),
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.isDark
                ? ThemeData.dark().copyWith(
                    iconTheme: const IconThemeData(color: Colors.black))
                : ThemeData.light(),
            initialRoute: '/',
            routes: {
              '/': (_) => const MapScreen(),
              '/settings': (_) => const SettingsScreen(),
            },
          );
        },
      ),
    );
  }
}
