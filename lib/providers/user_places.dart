import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_feature_app/model/place.dart';
import 'dart:io';
import "package:sqflite/sqlite_api.dart";
import "package:sqflite/sqflite.dart" as sql;

import "package:path_provider/path_provider.dart" as syspaths;
import "package:path/path.dart" as path;

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(
      dbPath,
      "places.db",
    ),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotofier extends StateNotifier<List<Place>> {
  UserPlacesNotofier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query("user_places");
    final places = data
        .map(
          (row) => Place(
            id: row["id"] as String,
            title: row["title"] as String,
            image: File(row["image"] as String),
            location: PlaceLocation(
              latitude: row["lat"] as double,
              longitude: row["lng"] as double,
              address: row["address"] as String,
            ),
          ),
        )
        .toList();

    state = places;
  }

  void addPlace(String title, File file, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(file.path);
    final copiedFile = await file.copy("${appDir.path}/$filename");

    final newPlace = Place(title: title, image: copiedFile, location: location);
    final db = await _getDatabase();
    db.insert("user_places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "lat": newPlace.location.latitude,
      "lng": newPlace.location.longitude,
      "address": newPlace.location.address
    });
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotofier, List<Place>>(
        (ref) => UserPlacesNotofier());
