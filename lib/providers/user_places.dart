import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_feature_app/model/place.dart';

class UserPlacesNotofier extends StateNotifier<List<Place>> {
  UserPlacesNotofier() : super(const []);

  void addPlace(String title) {
    final newPlace = Place(title: title);
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotofier, List<Place>>(
        (ref) => UserPlacesNotofier());
