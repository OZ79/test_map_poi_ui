import 'package:flutter/material.dart';
import 'package:test_map_poi_ui/presentation/map_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: SafeArea(child: MapScreen())),
    );
  }
}
