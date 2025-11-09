import 'package:test_map_poi_ui/data/datasources/poi_data_source.dart';
import 'package:test_map_poi_ui/data/models/poi.dart';
import 'package:test_map_poi_ui/domain/repositories/poi_repository.dart';

class PoiDaoRepositoryImpl implements PoiRepository {
  final PoiDataSource _poiDataSource;

  PoiDaoRepositoryImpl(this._poiDataSource);

  @override
  Future<List<Poi>> getPoi() async {
    final poiList = await _poiDataSource.getPoi();
    return poiList;
  }
}
