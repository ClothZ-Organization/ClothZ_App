import 'package:finding_clothes/src/features/dashboard/presentation/bookmark_presentation/bookmark_tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkPage extends ConsumerWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: SizedBox(
          height: 36,
          width: 226,
          child: ClipRRect(
            child: Image.asset(
              'assets/images/app_bar_bookMarks_img.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BookMarkTabPage(),
          ),
        ],
      ),
    );
  }
}
