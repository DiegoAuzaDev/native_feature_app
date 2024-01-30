import 'package:flutter/material.dart';

class AddPlaceScren extends StatefulWidget {
  const AddPlaceScren({super.key});

  @override
  State<AddPlaceScren> createState() => _AddPlaceScrenState();
}

class _AddPlaceScrenState extends State<AddPlaceScren> {
  final _titleController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
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
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                onPressed: () {},
                label: const Text("Save Place"),
              )
            ],
          ),
        ));
  }
}
