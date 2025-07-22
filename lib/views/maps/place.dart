import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart';

class Place with ClusterItem {
  final String name;
  final LatLng latLng;

  Place({required this.name, required this.latLng});

  factory Place.fromMap(Map<String, dynamic> map) {
    if (map['name'] == null || map['latitude'] == null || map['longitude'] == null) {
      throw Exception("Invalid data in Firestore document: $map");
    }

    return Place(
      name: map['name'] as String,
      latLng: LatLng(
        (map['latitude'] as num).toDouble(),
        (map['longitude'] as num).toDouble(),
      ),
    );
  }

  @override
  LatLng get location => latLng;

  @override
  String toString() {
    return 'Place{name: $name, latLng: $latLng}';
  }
}