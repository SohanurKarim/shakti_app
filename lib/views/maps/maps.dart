import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart'
as gmc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shakti_contact/views/maps/place.dart';

// Clustering maps

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => MapsState();
}

class MapsState extends State<Maps> {

  gmc.ClusterManager? _manager;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();

  //Here coding for Location permission get from user device
  Location location = new Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    setState(() {});
    print(_locationData);
  }
//End coding for Location permission get from user device

  //Here coding for primary set location
  final CameraPosition _parisCameraPosition = CameraPosition(
    target: LatLng(24.75058, 90.40968),
    zoom: 12.0,
  );
  //End coding for primary set location

  // List<Place> items = [
  //   Place(name: 'Sadar  Mymensingh-0134', latLng: LatLng(24.75058, 90.40968)),
  //   Place(
  //     name: 'Muktagacha Mymensingh-0171',
  //     latLng: LatLng(24.7639956, 90.2506356),
  //   ),
  //   Place(
  //     name: 'Fulbaria Mymensingh-0227',
  //     latLng: LatLng(24.641189, 90.274105),
  //   ),
  //   Place(
  //     name: 'Trishal Mymensingh-0339',
  //     latLng: LatLng(24.5788392, 90.3962873),
  //   ),
  //   Place(
  //     name: 'Bhaluka Mymensingh-0169',
  //     latLng: LatLng(24.4080804, 90.388751),
  //   ),
  //   Place(
  //     name: 'Gouripur Mymensingh-0239',
  //     latLng: LatLng(24.7501172, 90.5708166),
  //   ),
  //   Place(
  //     name: 'Ishwarganj  Mymensingh-0225',
  //     latLng: LatLng(24.67453, 90.60259),
  //   ),
  //   Place(name: 'Sadar Netrakona-0183', latLng: LatLng(24.880893, 90.741734)),
  //   Place(
  //     name: 'Phulpur Mymensingh-0209',
  //     latLng: LatLng(24.955259076197397, 90.35515409609758),
  //   ),
  //   Place(
  //     name: 'Haluaghat Mymensingh-0166',
  //     latLng: LatLng(25.12566, 90.34333),
  //   ),
  //   Place(name: 'Nalitabari Sherpur-0236', latLng: LatLng(25.09151, 90.19914)),
  //   Place(name: 'Nakla Sherpur-0154', latLng: LatLng(24.97297, 90.16571)),
  //   Place(name: 'Sadar Sherpur-0136', latLng: LatLng(25.0159422, 90.0130373)),
  //   Place(
  //     name: 'Sarishabari Jamalpur-0191',
  //     latLng: LatLng(24.757040, 89.836207),
  //   ),
  //   Place(name: 'Nandina Jamalpur-0216', latLng: LatLng(24.8683, 90.03785)),
  //   Place(name: 'Sadar Jamalpur -0083', latLng: LatLng(24.92643, 89.94388)),
  //   Place(
  //     name: ' Digpait Jamalpur-0438',
  //     latLng: LatLng(24.7690752, 89.9266925),
  //   ),
  // ];

  //Here coding for fetching data from firebase firestore
  List<Place> items = [];

  Future<void> _fetchPlacesFromFirestore() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('places').get();

    for (var doc in snapshot.docs) {
      print('Firestore doc ID: ${doc.id}, data: ${doc.data()}');
    }

    final places =
    snapshot.docs
        .where((doc) {
      final data = doc.data();
      return data.containsKey('name') &&
          data.containsKey('latitude') &&
          data.containsKey('longitude');
    })
        .map((doc) => Place.fromMap(doc.data()))
        .toList();

    // print('Fetched places: $places');
    //
    // if (places.isEmpty) {
    //   print('********No valid places found in Firestore.');
    // }

    setState(() {
      items = places;
      _manager?.setItems(items);
    });
  }
//End coding for fetching data from firebase firestore

  // Here coding for Set Marker
  Future<Marker> Function(gmc.Cluster<gmc.ClusterItem>) get _markerBuilder => (
      cluster,
      ) async {
    return Marker(
      markerId: MarkerId(cluster.getId()),
      position: cluster.location,
      onTap: () {
        print('---- $cluster');
        cluster.items.forEach((p) => print(p));
      },
      icon: await _getMarkerBitmap(
        cluster.isMultiple ? 125 : 75,
        text: cluster.isMultiple ? cluster.count.toString() : null,
      ),
    );
  };
  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.orange;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
          fontSize: size / 3,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }
// End coding for Set Marker

  //Here coding for set marker class
  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      this.markers = markers;
    });
  }

  gmc.ClusterManager _initClusterManager([
    List<Place> initialItems = const [],
  ]) {
    return gmc.ClusterManager<Place>(
      initialItems,
      _updateMarkers,
      markerBuilder: _markerBuilder,
    );
  }
  //End coding for set marker class


  //Here coding for calling all Class When app is start
  @override
  void initState() {
    getLocation();
    _manager = _initClusterManager([]);
    _fetchPlacesFromFirestore();
    super.initState();
  }
  //End coding for calling all Class When app is start


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Mymensingh Region(3506)',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.blueGrey,
      // ),
      body:
      (_locationData != null && _manager != null)
          ? GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _parisCameraPosition,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _manager?.setMapId(controller.mapId);
        },
        onCameraMove: (position) => _manager?.onCameraMove(position),
        onCameraIdle: () => _manager?.updateMap(),
        // onMapCreated: (GoogleMapController controller) {
        //   _controller.complete(controller);
        //   _manager.setMapId(controller.mapId);
        // },
        // onCameraMove: _manager.onCameraMove,
        // onCameraIdle: _manager.updateMap,
      )
          : Center(child: CircularProgressIndicator()),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final newItems = <Place>[
      //       for (int i = 0; i < 30; i++)
      //         Place(
      //           name: 'New Place ${DateTime.now()} $i',
      //           latLng: LatLng(48.858265 + i * 0.01, 2.350107),
      //         ),
      //     ];
      //     setState(() {
      //       _manager.setItems(newItems);
      //     });
      //   },
      //   child: Icon(Icons.update),
      // ),
    );
  }
}