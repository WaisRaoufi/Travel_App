import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app_riverpod/features/trip/presentation/pages/add_trip_screen.dart';
import 'package:travel_app_riverpod/features/trip/presentation/pages/my_trip_screen.dart';
import 'package:travel_app_riverpod/features/trip/presentation/providers/trip_provider.dart';

class MainScreen extends ConsumerWidget {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);
  String profilpic = '';
  MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tripListNotifierProvider.notifier).loadTrip();

    _pageController.addListener(() {
      _currentPage.value = _pageController.page!.round();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi  Fabrice 👌',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Travilling Today ? ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.all(20),
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(100),
        //       child: Image.network(
        //         profilpic,
        //         fit: BoxFit.cover,
        //         height: 60,
        //         width: 60,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: PageView(
        controller: _pageController,
        children: [MyTripScreen(), AddTripScreen(), Text('3')],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _currentPage,
        builder: (context, pageIndex, child) {
          return BottomNavigationBar(
            currentIndex: pageIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'My  Trips',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add  Trips',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Maps  Trips',
              ),
            ],
            onTap: (index) {
              _pageController.jumpToPage(index);
            },
          );
        },
      ),
    );
  }
}
