import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/services/presentation_service.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presentationService = ref.read(presentationServiceProvider);
    return MaterialApp.router(
      routerConfig: presentationService.router.config()
    );
  }
}
