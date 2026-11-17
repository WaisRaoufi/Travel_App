import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app_riverpod/features/trip/domain/entities/trip.dart';
import 'package:travel_app_riverpod/features/trip/presentation/providers/trip_provider.dart';

class AddTripScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: 'city 1');
  final _descController = TextEditingController(text: 'Best City ever');
  final _locationController = TextEditingController(text: 'Herat');
  final _pictureController = TextEditingController(text: 'http herat.png');
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
              }
            },
            child: Text('Add Trip'),
          ),
        ],
      ),
    );
  }
}
