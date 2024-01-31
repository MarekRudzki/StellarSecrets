import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stellar_secrets/features/daily/daily_screen.dart';
import 'package:stellar_secrets/features/home/view/no_network_screen.dart';
import 'package:stellar_secrets/features/home/viewModel/internet_connection_provider.dart';
import 'package:stellar_secrets/utils/icons.dart';
import 'package:stellar_secrets/features/random/random_screen.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _hasInternet = ref.watch(hasNetwork)! as bool;
    final _pageIndex = useState(0);

    final List<Widget> _pages = [
      const DailyScreen(),
      const RandomScreen(),
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
            )
          : const NoNetwork(),
    );
  }
}
