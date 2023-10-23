import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class NetworkAvailabilityService {
  late final StreamSubscription<ConnectivityResult> subscription;
  late bool isDeviceConnected;

  NetworkAvailabilityService() {
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      log("[NetworkAvailabilityService] - Connectivity changed to $result. Has internet access: $isDeviceConnected.");
    });
  }

  Future initialize() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
  }
}

final networkAvailabilityServiceProvider = Provider((ref) => NetworkAvailabilityService());
