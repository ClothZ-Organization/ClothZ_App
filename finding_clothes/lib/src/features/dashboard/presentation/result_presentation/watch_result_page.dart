import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchResultPage extends ConsumerWidget {
  const WatchResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final viewModel = ref.watch(resultPageViewModel);
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Text(
            "Watch",
            style: TextStyle(
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.w600,
              fontSize: 40.0,
              height: 1.12,
              color: Color(0xFF7C00FF),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
