import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_feature_app/model/place.dart';
import 'dart:io';

class UserPlacesNotofier extends StateNotifier<List<Place>> {
  UserPlacesNotofier() : super(const []);

  void addPlace(String title, File file, PlaceLocation location) {
    final newPlace = Place(title: title, image: file, location: location);
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotofier, List<Place>>(
        (ref) => UserPlacesNotofier());
