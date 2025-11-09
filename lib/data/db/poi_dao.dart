import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/models/poi.dart';

class PoiDao {
  static PoiDao? _instance;
  static Database? _db;

  PoiDao._();
  factory PoiDao() => _instance ??= PoiDao._();

  Future<Database> get database async {
    if (_db != null) return _db!;

    final path = join(await getDatabasesPath(), 'poi_kyiv.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
CREATE TABLE poi (
  id INTEGER PRIMARY KEY,
  name TEXT,
  description TEXT,
  lat REAL,
  lng REAL
)
''');

        final jsonString = await rootBundle.loadString('assets/seed.json');
        final List data = jsonDecode(jsonString);
        for (final item in data) {
          await db.insert('poi', item);
        }
      },
    );

    return _db!;
  }

  Future<List<Poi>> getPoi() async {
    final db = await database;
    final rows = await db.query('poi');
    return rows.map((item) => Poi.fromJson(item)).toList();
  }
}
