import 'dart:io';

import 'package:favorite_place/models/place.dart';
import 'package:favorite_place/providers/user_places.dart';
import 'package:favorite_place/widgets/image_input.dart';
import 'package:favorite_place/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});
  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _savePlace() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      return;
    }
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!, _selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              ImageInput(
                onPickedImage: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              LocationInput(onSelectLocation: (location) {
                _selectedLocation = location;
              }),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                onPressed: _savePlace,
                label: const Text('Add Place'),
                icon: const Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
    );
  }
}
