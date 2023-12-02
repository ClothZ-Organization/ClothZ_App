import 'package:finding_clothes/src/features/dashboard/application/result_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraScanPage extends ConsumerWidget {
   const CameraScanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(resultPageViewModel);
    return Scaffold();
  }

}