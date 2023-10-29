import 'package:finding_clothes/src/features/dashboard/application/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeViewModel);

    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: const Text('HomePage'),
      // ),
      body: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                height: double.infinity,
                width: MediaQuery.sizeOf(context).width / 2,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/images/womenD.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: double.infinity,
                width: MediaQuery.sizeOf(context).width / 2,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/images/manD.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: SafeArea(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Spacer(),
                  const Text(
                    "Scan ClothZ",
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                      height: 1.17,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Hello 👋🏻",
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 22.0,
                      height: 1.17,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(16.0),
                    color: const Color(0xFF222222),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.0),
                      onTap: () {
                        debugPrint('-- add Photo');
                      },
                      splashColor: Colors.transparent,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/images/folder_img.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Upload New",
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 30.0,
                      height: 1.16,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Scanned 483",
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 15.0,
                      height: 1.17,
                      color: Color(0xFFB7B7C1),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
