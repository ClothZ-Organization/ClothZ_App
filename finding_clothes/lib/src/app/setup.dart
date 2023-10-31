import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/domain/device_type.dart';
import '../shared/services/authentication/access_token_service.dart';
import '../shared/services/network_availability_service.dart';
import '../shared/services/platform_service.dart';
import '../shared/services/presentation_service.dart';
import '../shared/services/storage/shared_preferences_storage.dart';
import '../shared/services/storage/storage_service.dart';
import '../shared/utils/constants/ui_constants.dart';
import 'app_router.dart';

class Setup {
  static Future<ProviderContainer> initializeProviderContainer() async {
    // Init and override services that do not depend on other providers
    final independantOverrides = await _containerOverrides();

    final container = ProviderContainer(
      overrides: independantOverrides
    );

    // Remove any previously stored data on first app install (not default on native iOS)
    await _ensureCleanInitialAppStart(container);

    // Init services after the container overrides have already happened
    await _initializeServices(container);

    return container;
  }

  static Future<void> _ensureCleanInitialAppStart(ProviderContainer container) async {
    final storageService = container.read(storageServiceProvider);
    if (!storageService.appWasPreviouslyLaunched()) {
      log("[Setup] App launched for the first time.");

      await storageService.cleanAll();
      storageService.setAppWasPeviouslyLanched();
    }
  }

  static Future<List<Override>> _containerOverrides() async {
    final sharedPreferenceStorage = await _initializeSharedPreferencesService();
    final platformService = _initializePlatformService();

    return [
      sharedPreferencesStorageProvider.overrideWithValue(sharedPreferenceStorage),
      platformServiceProvider.overrideWithValue(platformService),
    ];
  }

  static Future _initializeServices(ProviderContainer container) async {
    await container.read(networkAvailabilityServiceProvider).initialize();
    await _initializePresentationService(container);
  }

  static Future _initializePresentationService(ProviderContainer container) async {
    final tokenAuthService = container.read(accessTokenServiceProvider);
    final storageService = container.read(storageServiceProvider);
    final isAuthenticated = await tokenAuthService.checkAuthentificationAndTryToRefreshToken();
    final router = AppRouter(isAuthenticated);
    container.read(presentationServiceProvider).intialize(router);
  }

  static Future<SharedPreferencesStorage> _initializeSharedPreferencesService() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return SharedPreferencesStorage(sharedPreferences);
  }

  static PlatformService _initializePlatformService() {
    DeviceType deviceIdiom;
    final data = MediaQueryData.fromView(PlatformDispatcher.instance.views.first);
    if (data.size.shortestSide > UIConstants.tabletPixelThreshold) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight, 
        DeviceOrientation.landscapeLeft
      ]);

      deviceIdiom = DeviceType.tablet;
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      deviceIdiom = DeviceType.phone;
    }

    return PlatformService(idiom: deviceIdiom);
  }
}
