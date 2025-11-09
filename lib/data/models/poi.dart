class Poi {
  final int id;
  final String name;
  final String description;
  final double lat;
  final double lng;

  Poi(
      {required this.id,
      required this.name,
      required this.description,
      required this.lat,
      required this.lng});

  factory Poi.fromJson(Map<String, dynamic> json) => Poi(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        lat: (json['lat'] as num).toDouble(),
        lng: (json['lng'] as num).toDouble(),
      );

  @override
  String toString() {
    return 'Poi(id: $id, name: $name, description: $description, lat: $lat, lng: $lng)';
  }
}
