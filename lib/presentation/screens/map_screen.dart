import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_map_poi_ui/presentation/blocs/map_bloc.dart';
import 'package:test_map_poi_ui/presentation/widgets/app_drawer.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('POI Map')),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state is MapPoiLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MapPoiLoadedState) {
              return FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(50.4501, 30.5234),
                  initialZoom: 12,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerClusterLayerWidget(
                    options: MarkerClusterLayerOptions(
                      maxClusterRadius: 100,
                      size: const Size(60, 60),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(50),
                      maxZoom: 15,
                      showPolygon: false,
                      markers: state.poiList
                          .map(
                            (poi) => Marker(
                              key: ValueKey(poi.id),
                              width: 80,
                              height: 85,
                              point: LatLng(poi.lat, poi.lng),
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 60.0,
                                  ),
                                  Text(
                                    poi.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      builder: (context, markers) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              markers.length.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        );
                      },
                      onMarkerTap: (marker) {
                        final poi = state.poiList.firstWhere((poi) =>
                            poi.lat == marker.point.latitude &&
                            poi.lng == marker.point.longitude);
                        Scaffold.of(context).showBottomSheet(
                          showDragHandle: true,
                          (context) => IntrinsicHeight(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: Center(
                                child: Text(
                                  '${poi.name} \n ${poi.description}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text('Помилка в завантаження'));
          },
        ),
      ),
    );
  }
}
