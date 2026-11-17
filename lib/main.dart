import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_app_riverpod/features/trip/data/models/trip_model.dart';
import 'package:travel_app_riverpod/features/trip/presentation/pages/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TripModelAdapter());
  await Hive.openBox<TripModel>('Trips');
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: ' Travel App', home: MainScreen(), debugShowCheckedModeBanner: false,);
  }
}
