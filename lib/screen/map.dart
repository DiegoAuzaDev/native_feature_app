import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:native_feature_app/model/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location =
        const PlaceLocation(latitude: 37.422, longitude: -122.084, address: ""),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? "Pick your location" : "Your location"),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
            )
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelecting
            ? null
            : (position) {
                setState(() {
                  _pickedLocation = position;
                });
              },
        initialCameraPosition: CameraPosition(
          zoom: 16,
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
        ),
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: MarkerId(
                    widget.location.address,
                  ),
                  position: _pickedLocation != null
                      ? _pickedLocation!
                      : LatLng(
                          widget.location.latitude,
                          widget.location.longitude,
                        ),
                ),
              },
      ),
    );
  }
}
