import 'package:finding_clothes/src/features/dashboard/application/home_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/result_page.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_clothes_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeViewModel);

    return Scaffold(
      backgroundColor: Colors.black,
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
          SafeArea(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
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
                      // viewModel.changeScreen();
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
                const SizedBox(
                  height: 16,
                ),

                // const Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Featured Products",
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          height: 1.14,
                          color: Color(0xFFFFFFFF),
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          debugPrint('Action See all.');
                        },
                        splashColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                        child: const Text(
                          ' See all ',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 1.17,
                            color: Color(0XFFC4C4C4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FCClothesCard(
                            title: 'title $index',
                            price: '\$$index',
                            nameBrand: 'H&M',
                            image: 'assets/images/imgClst.jpeg',
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
