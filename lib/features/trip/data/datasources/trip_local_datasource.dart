import 'package:hive/hive.dart';
import 'package:travel_app_riverpod/features/trip/data/models/trip_model.dart';

class TripLocalDatasource {
  final Box<TripModel> tripBox;

  TripLocalDatasource( this.tripBox);

  List<TripModel> getTrips() {
    return tripBox.values.toList();
  }

  void addTrip(TripModel trip) {
    tripBox.add(trip);
  }

  void deleteTrip(int index) async {
  if (index < 0 || index >= tripBox.length) {
    return;
  }

  await tripBox.deleteAt(index);  }
}
