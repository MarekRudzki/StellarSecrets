import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stellar_secrets/features/space_fact/view/daily_space_fact_screen.dart';
import 'package:stellar_secrets/features/home/view/no_network_screen.dart';
import 'package:stellar_secrets/features/home/viewModel/internet_connection_provider.dart';
import 'package:stellar_secrets/features/space_fact/view/random_space_fact_screen.dart';
import 'package:stellar_secrets/utils/icons.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _hasInternet =
        context.watch<InternetConnectionProvider>().hasInternet;
    final _pageIndex = useState(0);

    final List<Widget> _pages = [
      const DailySpaceFactScreen(),
      const RandomSpaceFactScreen(),
    ];

    return SafeArea(
      child: _hasInternet
          ? Scaffold(
              body: _pages[_pageIndex.value],
              backgroundColor: Theme.of(context).colorScheme.background,
              bottomNavigationBar: GNav(
                haptic: false,
                selectedIndex: _pageIndex.value,
                gap: 10,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                color: Colors.grey,
                activeColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                tabs: [
                  GButton(
                    icon: MyIcons.dailyPicture,
                    text: 'Daily fact',
                    onPressed: () {
                      _pageIndex.value = 0;
                    },
                    iconSize: 30,
                  ),
                  GButton(
                    icon: MyIcons.randomPicture,
                    text: 'Random fact',
                    onPressed: () {
                      _pageIndex.value = 1;
                    },
                    iconSize: 30,
                  ),
                ],
              ),
            )
          : const NoNetwork(),
    );
  }
}
