import 'package:flutter/material.dart';
import 'package:shakti_contact/views/maps/location_update.dart';
import 'maps.dart';

class MapsTabbedView extends StatelessWidget {
  const MapsTabbedView({super.key});


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Maps'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.map), text: 'Map View'),
              Tab(icon: Icon(Icons.edit_location), text: 'Update Info'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Maps(), // Existing clustering map widget
            BranchInfoForm(), // New update panel
          ],
        ),
      ),
    );
  }
}