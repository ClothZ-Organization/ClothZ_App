import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/domain/device_type.dart';
import '../utils/exceptions/provider_unimplemented_exception.dart';

class PlatformService {
  late final DeviceType _idiom;

  PlatformService({
    required DeviceType idiom
  }) {
    _idiom = idiom;
  }
  
  bool get isAndroid => Platform.isAndroid;

  bool get isIOS => Platform.isIOS;

  bool get isTablet => _idiom == DeviceType.tablet;

  bool get isPhone => _idiom == DeviceType.phone;
}

var platformServiceProvider = Provider<PlatformService>((ref) {
  throw ProviderNotImplementedException(serviceName: (PlatformService).toString());
});