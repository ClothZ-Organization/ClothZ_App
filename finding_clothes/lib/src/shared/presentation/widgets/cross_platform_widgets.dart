import 'dart:io';

import 'package:flutter/cupertino.dart';

class CrossPlatformWidget extends StatelessWidget {
  final Widget iosBuilder;
  final Widget androidBuilder;

  const CrossPlatformWidget({
    super.key,
    required this.iosBuilder,
    required this.androidBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? androidBuilder : iosBuilder;
  }
}