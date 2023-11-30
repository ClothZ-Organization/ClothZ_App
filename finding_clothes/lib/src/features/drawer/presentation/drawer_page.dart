import 'package:finding_clothes/src/features/drawer/application/drawer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

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
      elevation: 110,
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
            buttonDrawer(viewModel, context, 'lib/icons/edit.svg',
                'Privacy Policy', () {}),
            const SizedBox(
              height: 34,
            ),
            buttonDrawer(viewModel, context, 'lib/icons/clipboard-text.svg',
                'Terms & Conditions', () {}),
            const SizedBox(
              height: 34,
            ),
            buttonDrawer(viewModel, context, 'lib/icons/user-square.svg',
                'Community', () {}),
            const SizedBox(
              height: 34,
            ),
            buttonDrawer(viewModel, context, 'lib/icons/star.svg',
                'Leave a Review', () {}),
            const SizedBox(
              height: 34,
            ),
            buttonDrawer(viewModel, context, 'lib/icons/logout.svg', 'Log Out',
                () {
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

  Widget buttonDrawer(final viewModel, BuildContext context, String iconPath,
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
            SvgPicture.asset(
              iconPath,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcATop),
              height: 20,
              width: 20,
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
        Positioned(
          bottom: 0,
          right: 0,
          child: SvgPicture.asset(
            'lib/icons/gallery.svg',
            colorFilter:
                const ColorFilter.mode(Colors.white, BlendMode.srcATop),
            height: 32,
            width: 32,
          ),
        ),
      ],
    );
  }
}