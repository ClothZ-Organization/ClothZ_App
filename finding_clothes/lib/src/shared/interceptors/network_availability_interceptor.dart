import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:finding_clothes/src/shared/services/network_availability_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class NetworkAvailabilityInterceptor extends Interceptor {
  late final NetworkAvailabilityService _networkAvailabilityService;
  // late final PresentationService _presentationService;

  NetworkAvailabilityInterceptor(Ref ref) {
    _networkAvailabilityService = ref.watch(networkAvailabilityServiceProvider);
    // _presentationService = ref.watch(presentationServiceProvider);
  }

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_networkAvailabilityService.isDeviceConnected) {
      super.onRequest(options, handler);
    } else {
      // _presentationService.showDialog(
      //   title: TextResources.offlinePopupTitle,
      //   message: TextResources.offlinePopupMessage,
      // );

      log("Unable to perform the request since the device has no internet connection.");
    }
  }
}