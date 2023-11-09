import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClothesBookmarkPage extends ConsumerWidget {
  const ClothesBookmarkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final viewModel = ref.watch();
    return const Padding(
      padding:  EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            "Clothes Bookmarks",
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
