import 'package:dio/dio.dart';
import 'package:finding_clothes/src/shared/interceptors/access_token_interceptor.dart';
import 'package:finding_clothes/src/shared/interceptors/network_availability_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final accessTokenInterceptor = ref.watch(accessTokenInterceptorProvider);
  final networkAvailabilityInterceptor = NetworkAvailabilityInterceptor(ref);

  dio.interceptors.add(networkAvailabilityInterceptor);
  dio.interceptors.add(accessTokenInterceptor);
  return dio;
});