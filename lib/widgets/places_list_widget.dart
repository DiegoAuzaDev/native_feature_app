import 'package:flutter/material.dart';
import 'package:native_feature_app/model/place.dart';
import 'package:native_feature_app/screen/places_details.dart';

class PlaceListWidget extends StatelessWidget {
  const PlaceListWidget({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    // no places found
    const Widget noPlaces = Center(
      child: Text("There is no data in the list"),
    );
    // list with places

    Widget controller() {
      if (places.isEmpty) {
        return noPlaces;
      }
      return ListView.builder(
        itemCount: places.length,
        itemBuilder: (ctx, index) => ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (contex) => PlaceDetailScreen(place: places[index]),
              ),
            );
          },
          title: Text(
            places[index].title,
          ),
        ),
      );
    }

    return controller();
  }
}
