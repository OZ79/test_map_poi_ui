import 'package:test_map_poi_ui/data/models/poi.dart';

abstract class PoiRepository {
  Future<List<Poi>> getPoi();
}
