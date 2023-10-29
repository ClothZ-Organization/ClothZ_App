import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkPage extends ConsumerWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookmarkPage'),
      ),
      body: const Center(
        child: Text("Bookmark Page"),
      ),
    );
  }
}