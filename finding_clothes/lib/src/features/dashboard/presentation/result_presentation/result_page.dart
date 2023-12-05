import 'dart:io';

import 'package:finding_clothes/src/features/dashboard/application/result_page_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/result_presentation/all_result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ResultPage extends ConsumerWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(resultPageViewModel);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          highlightColor: Colors.grey,
          iconSize: 22,
          icon: SvgPicture.asset(
            'lib/icons/arrow-back.svg',
            colorFilter:
                const ColorFilter.mode(Colors.white, BlendMode.srcATop),
            height: 22,
            width: 22,
          ),
          onPressed: () {
            viewModel.setPageNumber(1);
          },
        ),
        title: const Text(
          'Searched Product',
          style: TextStyle(
            fontFamily: 'WorkSans',
            fontWeight: FontWeight.w600,
            fontSize: 22.0,
            height: 1.17,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.21,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.0),
                  child: _buildImageWidget(
                    viewModel.imagePath(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 33,
            ),
            Expanded(
              child: AllResultPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
      );
    }
  }
}
