import 'package:flutter/cupertino.dart';

import 'empty_widget.dart';

class Optional<T> extends StatelessWidget {
  final T? optional;
  final Widget Function(T) widgetBuilder;
  final Widget callbackWidget;

  const Optional({
    super.key, 
    required this.optional, 
    required this.widgetBuilder,
    this.callbackWidget = const EmptyWidget()
  });

  @override
  Widget build(BuildContext context) {
    final unwrappableOptional = optional;
    if (unwrappableOptional is T) {
      return widgetBuilder(unwrappableOptional);
    } else {
      return callbackWidget;
    }
  }
}