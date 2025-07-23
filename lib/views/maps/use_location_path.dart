import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:share_plus/share_plus.dart';

class MapWithDirectionsPage extends StatefulWidget {
  @override
  _MapWithDirectionsPageState createState() => _MapWithDirectionsPageState();
}

class _MapWithDirectionsPageState extends State<MapWithDirectionsPage> {
  GoogleMapController? _mapController;
  final Location _location = Location();
  LocationData? _currentLocation;

  final LatLng _destination = LatLng(25.12566, 90.34333); // Example destination
 // final String _googleApiKey = 'AIzaSyC97e3XfTR8kztXh1xJbkVf8756KLtOVjk';

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final List<LatLng> _polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    final permission = await _location.requestPermission();
    if (permission != PermissionStatus.granted) return;

    final loc = await _location.getLocation();
    setState(() {
      _currentLocation = loc;
      _setMarkers();
    });
  }

  void _setMarkers() {
    _markers.clear();

    if (_currentLocation != null) {
      _markers.add(Marker(
        markerId: MarkerId("current"),
        position: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        infoWindow: InfoWindow(title: "You"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ));
    }

    _markers.add(Marker(
      markerId: MarkerId("destination"),
      position: _destination,
      infoWindow: InfoWindow(title: "Destination"),
    ));
  }

  Future<void> _drawRoute() async {
    if (_currentLocation == null) return;

   // PolylinePoints polylinePoints = PolylinePointsy();

    PolylinePoints polylinePoints = PolylinePoints(apiKey: "AIzaSyDAYqIr1YINdE9jk_E-Ll-2ZXqDlHkh5Bw");

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(_currentLocation!.latitude!, _currentLocation!.longitude!), // San Francisco
        destination: PointLatLng(_destination.latitude, _destination.longitude), // San Jose
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      _polylineCoordinates.clear();
      result.points.forEach((point) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.clear();
        _polylines.add(Polyline(
          polylineId: PolylineId("route"),
          color: Colors.red,
          width: 10,
          points: _polylineCoordinates,
        ));
      });
    }
  }


  void _showOptionsSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.directions_car),
              title: Text('Start Directions'),
              onTap: () async {
                Navigator.pop(context);
                await _drawRoute();  // 👈 Wait for polyline to finish
                _zoomToFitRoute();   // 👈 Now zoom will work properly
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Save Location'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Location saved')));
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share Location'),
              onTap: () {
                Navigator.pop(context);
                final lat = _destination.latitude;
                final lng = _destination.longitude;
                Share.share(
                    'Check out this location: https://www.google.com/maps/search/?api=1&query=$lat,$lng');
              },
            ),
            ListTile(
              leading: Icon(Icons.label),
              title: Text('Add Label'),
              onTap: () {
                Navigator.pop(context);
                _showLabelDialog();
              },
            ),
            ListTile(
              leading: Icon(Icons.more_horiz),
              title: Text('More Options'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('More options coming soon')));
              },
            ),
          ],
        );
      },
    );
  }

  void _showLabelDialog() {
    TextEditingController _labelController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Label"),
        content: TextField(
          controller: _labelController,
          decoration: InputDecoration(hintText: "Enter a label"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Label added: ${_labelController.text}')),
              );
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _zoomToFitRoute() {
    if (_currentLocation == null) return;

    final bounds = _boundsFromLatLngList([
      LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
      _destination,
    ]);

    _mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double x0 = list[0].latitude;
    double x1 = list[0].latitude;
    double y0 = list[0].longitude;
    double y1 = list[0].longitude;

    for (LatLng latLng in list) {
      if (latLng.latitude > x1) x1 = latLng.latitude;
      if (latLng.latitude < x0) x0 = latLng.latitude;
      if (latLng.longitude > y1) y1 = latLng.longitude;
      if (latLng.longitude < y0) y0 = latLng.longitude;
    }

    return LatLngBounds(
      northeast: LatLng(x1, y1),
      southwest: LatLng(x0, y0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map with Directions'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: _showOptionsSheet,
          ),
        ],
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
          zoom: 14,
        ),
        markers: _markers,
        polylines: _polylines,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (controller) => _mapController = controller,
      ),
    );
  }
}
