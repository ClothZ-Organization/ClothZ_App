import 'dart:ffi';

import 'package:finding_clothes/src/features/drawer/application/drawer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerPage extends ConsumerWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(drawerViewModelProvider);

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      width: MediaQuery.of(context).size.width * 0.76,
      backgroundColor: Colors.black,
      shadowColor: const Color(0xFF7C00FF),
      elevation: 50,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  height: 1.25,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 31,
            ),
            Center(
              child: Material(
                  borderRadius: const BorderRadius.all(Radius.circular(90)),
                  color: const Color(0xFF222222),
                  child: imageDrawer(MediaQuery.of(context).size.width * 0.33)),
            ),
            const SizedBox(
              height: 45,
            ),
            buttonDrawer(viewModel, context, Icons.edit_document,
                'Privacy Policy', () {}),
            const SizedBox(
              height: 34,
            ),
            buttonDrawer(viewModel, context, Icons.file_open_outlined,
                'Terms & Conditions', () {}),
            const SizedBox(
              height: 34,
            ),
            buttonDrawer(viewModel, context, Icons.person_outline_rounded,
                'Community', () {}),
            const SizedBox(
              height: 34,
            ),
            buttonDrawer(
                viewModel, context, Icons.star_border, 'Leave a Review', () {}),
            const SizedBox(
              height: 34,
            ),
            buttonDrawer(viewModel, context, Icons.logout, 'Log Out', () {
              viewModel.logOut();
            }),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: MediaQuery.paddingOf(context).bottom,
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonDrawer(final viewModel, BuildContext context, IconData iconData,
      String nameButton, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        child: Row(
          //nu e perfect
          children: <Widget>[
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.082,
            ),
            Icon(
              iconData,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              nameButton,
              style: const TextStyle(
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
                height: 1.1,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageDrawer(double sizeImg) {
    return Stack(
      children: <Widget>[
        Material(
          borderRadius: const BorderRadius.all(Radius.circular(90)),
          color: const Color(0xFF222222),
          child: InkWell(
            borderRadius: BorderRadius.circular(90.0),
            splashColor: Colors.transparent,
            highlightColor: Colors.grey,
            child: Container(
              height: sizeImg,
              width: sizeImg,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(90.0),
                ),
                child: Opacity(
                  opacity: 0.8,
                  child: Image.asset(
                    'assets/images/profile.jpeg',
                    width: sizeImg,
                    height: sizeImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            onTap: () {
              debugPrint('Click on image');
            },
          ),
        ),
        const Positioned(
          bottom: 0,
          right: 0,
          child: Icon(
            Icons.image,
            color: Colors.white,
            size: 32,
          ),
        ),
      ],
    );
  }
}
