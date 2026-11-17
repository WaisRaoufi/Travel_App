import 'package:dartz/dartz.dart';
import 'package:travel_app_riverpod/core.error/failures.dart';
import 'package:travel_app_riverpod/features/trip/domain/entities/trip.dart';
import 'package:travel_app_riverpod/features/trip/domain/repositories/trip_repository.dart';

class GetTrip {
  final TripRepository repository;

  GetTrip(this.repository);
  Future<Either<Failure, List<Trip>>> call() {
    return repository.getTrips();
  }
}
