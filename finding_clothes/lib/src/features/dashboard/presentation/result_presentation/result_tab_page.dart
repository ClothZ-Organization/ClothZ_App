import 'package:finding_clothes/src/features/dashboard/presentation/result_presentation/all_result_page.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_top_title_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultTabPage extends ConsumerWidget {
  const ResultTabPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Material(
              color: Colors.black,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  // width: ,
                  child: Center(
                    child: FCTopTitlePage(nameText: 'Search results',),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AllResultPage(),
                  // ClothesResultPage(),
                  // WatchResultPage(),
                  // AccesoriesResultPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
