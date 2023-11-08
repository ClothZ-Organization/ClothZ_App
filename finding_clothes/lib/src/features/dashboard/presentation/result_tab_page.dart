import 'package:finding_clothes/src/features/dashboard/presentation/accessories_result_page.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/all_result_page.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/clothes_result_page.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/watch_result_page.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_top_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultTabPage extends ConsumerWidget {
  const ResultTabPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Material(
              color: Colors.black,
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: FCTopTabBar(),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AllResulPage(),
                  ClothesResulPage(),
                  WatchResulPage(),
                  AccesoriesResulPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
