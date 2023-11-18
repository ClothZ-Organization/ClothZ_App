import 'package:flutter/material.dart';

class FCTopTabBar extends StatelessWidget {
  const FCTopTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TabBar(
        isScrollable: true,
        tabs: const [
          Tab(
            child: Text(
              "All",
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                height: 1.12,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Hoodie",
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                height: 1.12,
                color: Colors.white,
                // decoration: TextDecoration.none,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Watch",
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                height: 1.12,
                color: Colors.white,
                // decoration: TextDecoration.none,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Accessories",
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                height: 1.12,
                color: Colors.white,
              ),
            ),
          ),
        ],
        splashBorderRadius: BorderRadius.circular(8),
        splashFactory: NoSplash.splashFactory,
        indicator: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF000000),
              Color(0xFF7C00FF),
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        dividerColor: Colors.transparent,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: -10),
      ),
    );
  }
}
