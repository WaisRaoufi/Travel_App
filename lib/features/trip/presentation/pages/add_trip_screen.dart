import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app_riverpod/features/trip/domain/entities/trip.dart';
import 'package:travel_app_riverpod/features/trip/presentation/providers/trip_provider.dart';

class AddTripScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: '');
  final _descController = TextEditingController(text: '');
  final _locationController = TextEditingController(text: '');
  final _pictureController = TextEditingController(text: '');
  List<String> pictures = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextFormField(
            controller: _descController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          TextFormField(
            controller: _locationController,
            decoration: InputDecoration(labelText: 'Location'),
          ),
          TextFormField(
            controller: _pictureController,
            decoration: InputDecoration(labelText: 'photo'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_titleController.text.trim().isEmpty) {
                return;
              }
              pictures.add(_pictureController.text);
              if (_formKey.currentState!.validate()) {
                final newTrip = Trip(
                  title: _titleController.text,
                  photos: pictures,
                  description: _descController.text,
                  date: DateTime.now(),
                  location: _locationController.text,
                );
                ref.read(tripListNotifierProvider.notifier).addNewTrip(newTrip);
                ref.watch(tripListNotifierProvider.notifier).loadTrip();
                _titleController.clear();
                _descController.clear();
                _locationController.clear();
                _pictureController.clear();

                pictures.clear();
              }
            },
            child: Text('Add Trip'),
          ),
        ],
      ),
    );
  }
}
