import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_app_riverpod/features/trip/data/datasources/trip_local_datasource.dart';
import 'package:travel_app_riverpod/features/trip/data/models/trip_model.dart';
import 'package:travel_app_riverpod/features/trip/data/repositories/trip_repository_impl.dart';
import 'package:travel_app_riverpod/features/trip/domain/entities/trip.dart';
import 'package:travel_app_riverpod/features/trip/domain/repositories/trip_repository.dart';
import 'package:travel_app_riverpod/features/trip/domain/usescases/add_trip.dart';
import 'package:travel_app_riverpod/features/trip/domain/usescases/delete_trip.dart';
import 'package:travel_app_riverpod/features/trip/domain/usescases/get_trip.dart';
import 'package:flutter_riverpod/legacy.dart';

final tripLocalDataSourceProvider = Provider<TripLocalDatasource>((ref) {
  final Box<TripModel> tripBox = Hive.box('trips');
  return TripLocalDatasource(tripBox);
});
final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final localDataSource = ref.read(tripLocalDataSourceProvider);
  return TripRepositoryImpl(localDataSource);
});
final addTripProvider = Provider<AddTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return AddTrip(repository);
});

final getTripsProvider = Provider<GetTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return GetTrip(repository);
});
final deleteTripProvider = Provider<DeleteTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return DeleteTrip(repository);
});

final tripListNotifierProvider =
    StateNotifierProvider<TripListNotifier, List<Trip>>((ref) {
      final getTrips = ref.read(getTripsProvider);
      final addTrip = ref.read(addTripProvider);
      final deleteTrip = ref.read(deleteTripProvider);

      return TripListNotifier(getTrips, addTrip, deleteTrip);
    });

class TripListNotifier extends StateNotifier<List<Trip>> {
  final GetTrip _getTrip;
  final AddTrip _addTrip;
  final DeleteTrip _deleteTrip;

  TripListNotifier(this._getTrip, this._addTrip, this._deleteTrip) : super([]);

  Future<void> addNewTrip(Trip trip) async {
    await _addTrip(trip);
  }

  Future<void> removeTrip(int index) async {

    await _deleteTrip(index);
    await loadTrip();

  }

  Future<void> loadTrip() async {
    final tripOrFailure = await _getTrip();

    tripOrFailure.fold((error) => state = [], (trips) => state = trips);
  }
}
