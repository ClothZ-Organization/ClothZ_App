import 'package:finding_clothes/src/features/dashboard/application/camera_page_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/result_presentation/camera_scan_page.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/result_presentation/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultStrategyPage extends ConsumerWidget {
  const ResultStrategyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(cameraPageViewModel);
    return viewModel.isCameraScanPage()
        ? const CameraScanPage()
        : const ResultPage();
  }
}
