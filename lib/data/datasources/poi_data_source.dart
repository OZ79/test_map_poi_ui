import 'package:test_map_poi_ui/data/db/poi_dao.dart';
import 'package:test_map_poi_ui/data/models/poi.dart';

abstract class PoiDataSource {
  Future<List<Poi>> getPoi();
}

class PoiDaoDataSourceImpl implements PoiDataSource {
  final PoiDao _poiDao = PoiDao();

  @override
  Future<List<Poi>> getPoi() async {
    final poiList = await _poiDao.getPoi();
    return poiList;
  }
}
