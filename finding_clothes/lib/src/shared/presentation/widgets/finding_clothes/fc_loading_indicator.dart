import 'package:finding_clothes/src/shared/domain/loading_indicator_size.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/cross_platform_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FCLoadingIndicator extends StatelessWidget {
  final LoadingIndicatorSize size;
  const FCLoadingIndicator({super.key, this.size = LoadingIndicatorSize.standart});

  @override
  Widget build(BuildContext context) {
    return CrossPlatformWidget(
      iosBuilder: CupertinoActivityIndicator(
        radius: size.diameter / 2,
        color: const Color(0xFF7C00FF)
      ),
      androidBuilder: Center(
        child: SizedBox(
          width: size.diameter,
          height: size.diameter,
          child: CircularProgressIndicator(
            strokeWidth: size.circularIndicatorStrokeWidth,
            color: const Color(0xFF7C00FF),
          ),
        ),
      ) ,
    );
  }
}