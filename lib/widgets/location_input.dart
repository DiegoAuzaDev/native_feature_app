import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import "package:http/http.dart" as http;
import 'package:native_feature_app/model/place.dart';
import 'package:native_feature_app/screen/map.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectedLocation});

  final void Function(PlaceLocation lcation) onSelectedLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickLocation;

  var _isGettingLocation = false;

  String get locationImage {
    if (_pickLocation == null) {
      return "";
    }
    final lat = _pickLocation!.latitude;
    final lng = _pickLocation!.longitude;
    const myGoogleKey = "AIzaSyB24W6tg3Ko7JcE8K0quH-5_XM-haeSB5I";
    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$myGoogleKey";
  }

  Future<void> _savePlace(double latitude, double longitude) async {
    // my key
    String myGoogleKey = "AIzaSyB24W6tg3Ko7JcE8K0quH-5_XM-haeSB5I";
    // parsing the google map url

    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$myGoogleKey");
    // awaiting the response
    final responseGoogleMap = await http.get(url);
    // getting the body of the response
    final responseBody = json.decode(responseGoogleMap.body);
    // accesing addres into the response body
    final address = responseBody["results"][0]["formatted_address"];
    setState(() {
      _pickLocation = PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        address: address,
      );
      _isGettingLocation = false;
    });
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGettingLocation = true;
    });
    locationData = await location.getLocation();
    // saving lat and log in final
    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    if (latitude == null || longitude == null) {
      return;
    }
    _savePlace(latitude, longitude);
    widget.onSelectedLocation(_pickLocation!);
  }

  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context)
        .push<LatLng>(MaterialPageRoute(builder: (ctx) => const MapScreen()));
    if (pickedLocation == null) {
      return;
    }
    _savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      "No location chosen",
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (_pickLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
          ),
          height: 170,
          width: double.infinity,
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: const Text("Get current location"),
              icon: const Icon(
                Icons.location_on,
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              label: const Text("Select on map"),
              icon: const Icon(
                Icons.map,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
