import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stellar_secrets/daily_screen.dart';
import 'package:stellar_secrets/icons.dart';
import 'package:stellar_secrets/random_screen.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _pageIndex = useState(0);

    final List<Widget> _pages = [
      const DailyScreen(),
      const RandomScreen(),
    ];

    return SafeArea(
      child: Scaffold(
        body: _pages[_pageIndex.value],
        backgroundColor: Theme.of(context).colorScheme.background,
        bottomNavigationBar: GNav(
          haptic: false,
          selectedIndex: _pageIndex.value,
          gap: 10,
          backgroundColor: const Color.fromARGB(255, 53, 48, 87),
          color: Colors.grey,
          activeColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 15,
          ),
          tabs: [
            GButton(
              icon: MyIcons.daily,
              text: 'Daily',
              onPressed: () {
                _pageIndex.value = 0;
              },
              iconSize: 30,
            ),
            GButton(
              icon: MyIcons.random,
              text: 'Random',
              onPressed: () {
                _pageIndex.value = 1;
              },
              iconSize: 30,
            ),
          ],
        ),
        // BottomNavigationBar(
        //   onTap: (value) {
        //     _pageIndex.value = value;
        //   },
        //   currentIndex: _pageIndex.value,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Image.asset(
        //         'assets/daily2.png',
        //         height: _pageIndex.value == 0 ? 40 : 30,
        //       ),
        //       label: 'Daily',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Image.asset(
        //         'assets/random2.png',
        //         height: _pageIndex.value == 1 ? 40 : 30,
        //       ),
        //       label: 'Random',
        //     ),
        //   ],
        //   backgroundColor: const Color.fromARGB(255, 64, 46, 105),
        //   selectedLabelStyle: const TextStyle(
        //     fontSize: 18,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.white,
        //   ),
        //   unselectedLabelStyle: const TextStyle(
        //     fontSize: 16,
        //   ),
        // ),
      ),
    );
  }
}
