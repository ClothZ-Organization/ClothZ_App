import 'dart:io';

import 'package:finding_clothes/firebase_options.dart';
import 'package:finding_clothes/src/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (Platform.isAndroid) {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: Colors.transparent));
  }

  final providerContainer = await Setup.initializeProviderContainer();

  runApp(UncontrolledProviderScope(
    container: providerContainer,
    child: const App(),
  ));
}