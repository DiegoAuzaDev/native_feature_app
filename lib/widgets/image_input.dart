import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  void _takePicture() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        ),
      ),
      alignment: Alignment.center,
      height: 250,
      width: double.infinity,
      child: TextButton.icon(
        icon: const Icon(Icons.camera_alt),
        label: const Text("Take a picture"),
        onPressed: _takePicture,
      ),
    );
  }
}
