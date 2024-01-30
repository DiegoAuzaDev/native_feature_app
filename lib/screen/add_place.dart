import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_feature_app/providers/user_places.dart';
import 'package:native_feature_app/widgets/image_input.dart';

class AddPlaceScren extends ConsumerStatefulWidget {
  const AddPlaceScren({super.key});

  @override
  ConsumerState<AddPlaceScren> createState() => _AddPlaceScrenState();
}

class _AddPlaceScrenState extends ConsumerState<AddPlaceScren> {
  final _titleController = TextEditingController();

  void _savePlace() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid input"),
        ),
      );
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(enteredTitle);
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
              const ImageInput(),
              const SizedBox(
                height: 20,
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
