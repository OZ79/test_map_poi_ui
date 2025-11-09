import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_map_poi_ui/data/models/poi.dart';
import 'package:test_map_poi_ui/domain/repositories/poi_repository.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();
  @override
  List<Object> get props => [];
}

class MapLoadPoiEvent extends MapEvent {}

abstract class MapState extends Equatable {
  const MapState();
  @override
  List<Object> get props => [];
}

class MapPoiLoadingState extends MapState {}

class MapPoiLoadedState extends MapState {
  final List<Poi> poiList;
  const MapPoiLoadedState(this.poiList);
  @override
  List<Object> get props => [poiList];
}

class MapBloc extends Bloc<MapEvent, MapState> {
  final PoiRepository repo;

  MapBloc(this.repo) : super(MapPoiLoadingState()) {
    on<MapLoadPoiEvent>(_onMapLoadPoi);
  }

  Future<void> _onMapLoadPoi(
    MapLoadPoiEvent event,
    Emitter<MapState> emit,
  ) async {
    emit(MapPoiLoadingState());
    final poi = await repo.getPoi();
    emit(MapPoiLoadedState(poi));
  }
}
