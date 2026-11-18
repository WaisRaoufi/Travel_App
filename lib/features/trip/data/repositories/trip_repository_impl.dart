import 'package:dartz/dartz.dart';
import 'package:travel_app_riverpod/core.error/failures.dart';
import 'package:travel_app_riverpod/features/trip/data/datasources/trip_local_datasource.dart';
import 'package:travel_app_riverpod/features/trip/data/models/trip_model.dart';
import 'package:travel_app_riverpod/features/trip/domain/entities/trip.dart';
import 'package:travel_app_riverpod/features/trip/domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDatasource localDataource;

  TripRepositoryImpl(this.localDataource);
  @override
  Future<void> addTrips(Trip trip) async {
    final tripModel = TripModel.fromEntity(trip);
    localDataource.addTrip(tripModel);
  }

  @override
  Future<void> deleteTrips(int index) async {
   localDataource.deleteTrip(index);
  }

  @override
  Future<Either<Failure ,List<Trip>>> getTrips() async {
    try {
      final tripModels = localDataource.getTrips();
    List<Trip> res = tripModels.map((model) => model.toEntity()).toList();
    return Right(res);
    }catch(err) {
      return left(SomeSpecificError(err.toString()));
    }
    
  }
}
