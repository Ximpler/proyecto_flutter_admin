import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:loggy/loggy.dart';

class NetworkInfo with UiLoggy {
  late StreamSubscription<InternetStatus> _internetStatusSubscription;
  late StreamController<bool> _controller;

  Stream<bool> get stream => _controller.stream;

  NetworkInfo() {
    _controller = StreamController<bool>.broadcast();
  }

  void openStream() {
    _internetStatusSubscription = InternetConnection()
        .onStatusChange
        .listen(_internetStatusSubscriptionListener);
    loggy.info('Started listening to internet status changes.');
  }

  void closeStream() {
    _internetStatusSubscription.cancel();
    loggy.info('Stopped listening to internet status changes.');
  }

  void _addValue(bool value) {
    _controller.add(value);
    loggy.info('Internet status changed: $value');
  }

  void dispose() {
    _controller.close();
    loggy.info('NetworkInfo disposed.');
  }

  Future<bool> isConnected() async {
    bool connected = await InternetConnection().hasInternetAccess;
    loggy.info('Checking internet connection: $connected');
    return connected;
  }

  void _internetStatusSubscriptionListener(InternetStatus status) {
    _addValue(status == InternetStatus.connected);
    loggy.info('Internet status listener: $status');
  }
}