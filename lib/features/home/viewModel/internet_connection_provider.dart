import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionProvider extends StateNotifier<bool> {
  InternetConnectionProvider() : super(true) {
    startInternetListener();
  }

  void startInternetListener() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      status == InternetConnectionStatus.connected
          ? state = true
          : state = false;
    });
  }
}

final hasNetwork = StateNotifierProvider((ref) {
  return InternetConnectionProvider();
});
