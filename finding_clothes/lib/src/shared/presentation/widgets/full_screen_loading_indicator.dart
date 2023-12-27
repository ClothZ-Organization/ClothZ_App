import 'package:auto_route/auto_route.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_loading_indicator.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/round_rect.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "FullScreenLoadingIndicatorRoute")
class FullScreenLoadingIndicator extends StatelessWidget {
  static const double _size = 120;
  const FullScreenLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: Center(
        child: SizedBox(
          height: _size,
          width: _size,
          child: RoundRect(
            radius: 12,
            child: const Center(
              child: FCLoadingIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
