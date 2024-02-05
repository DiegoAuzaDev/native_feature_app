import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_feature_app/model/place.dart';
import 'package:native_feature_app/providers/user_places.dart';
import 'package:native_feature_app/widgets/image_input.dart';
import 'dart:io';

import 'package:native_feature_app/widgets/location_input.dart';

class AddPlaceScren extends ConsumerStatefulWidget {
  const AddPlaceScren({super.key});

  @override
  ConsumerState<AddPlaceScren> createState() => _AddPlaceScrenState();
}

class _AddPlaceScrenState extends ConsumerState<AddPlaceScren> {
  File? _selectedImage;
  final _titleController = TextEditingController();
  PlaceLocation? _selectedLocation;

  void _savePlace() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You must add an image and also a valid input"),
        ),
      );
      return;
    }
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!, _selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add new Place"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                maxLength: 20,
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
                controller: _titleController,
              ),
              const SizedBox(
                height: 20,
              ),
              ImageInput(
                onPickedImage: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              LocationInput(
                onSelectedLocation: (location) {
                  _selectedLocation = location;
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _savePlace();
                },
                label: const Text("Save Place"),
              )
            ],
          ),
        ));
  }
}
