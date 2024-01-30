import 'package:flutter/material.dart';
import 'package:native_feature_app/screen/add_place.dart';
import 'package:native_feature_app/widgets/places_list_widget.dart';

class PlacesListScreen extends StatefulWidget {
  const PlacesListScreen({super.key});

  @override
  State<PlacesListScreen> createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddPlaceScren()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const PlaceListWidget(places: []),
    );
  }
}
