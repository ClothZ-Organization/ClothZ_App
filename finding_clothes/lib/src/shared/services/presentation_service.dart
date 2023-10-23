import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../app/app_router.dart';
import '../domain/alert_action.dart';
import '../domain/alert_model.dart';
import '../utils/resources/text_resources.dart';

class PresentationService {
  late final AppRouter router;

  bool get canNavigateBack {
    return true;//router.canNavigateBack;
  }

  void intialize(AppRouter router) {
    this.router = router;
  }

  // Future showLoading(Future Function() future) async {
  //   await router.push(const FullScreenLoadingIndicatorRoute());
  //   await future();
  //   await router.pop();
  // }


  // void showDialog({
  //   required String title,
  //   required String message,
  //   String confirmText = TextResources.confirm,
  //   bool dismissOnTapOutside = true,
  //   VoidCallback? onConfirm,
  //   VoidCallback? onCancel,
  // }) {
  //   AlertAction? onConfirmAction;
  //   AlertAction? onCancelAction;

  //   if (onConfirm != null) {
  //     onConfirmAction = AlertAction(title: confirmText, callback: onConfirm);
  //   }

  //   if (onCancel != null) {
  //     onCancelAction = AlertAction(title: TextResources.cancel, callback: onCancel);
  //   }

  //   final alertModel = AlertModel(
  //     title: title,
  //     message: message,
  //     onCancel: onCancelAction,
  //     onConfirm: onConfirmAction,
  //     dismissOnTapOutside: dismissOnTapOutside,
  //   );

  //   router.push(AlertDialogRoute(model: alertModel));
  // }

  // void showInputDialog({
  //   required String title,
  //   required Function(String) onConfirm,
  //   String? message,
  //   String confirmText = TextResources.confirm,
  //   bool dismissOnTapOutside = true,
  //   String? initialValue,
  //   int? maxLength,
  //   Function()? onCancel,
  // }) {
  //   InputAlertAction<String>? onConfirmAction;
  //   AlertAction? onCancelAction;

  //   onConfirmAction = InputAlertAction<String>(title: confirmText, callback: onConfirm);

  //   if (onCancel != null) {
  //     onCancelAction = AlertAction(title: TextResources.cancel, callback: onCancel);
  //   }

  //   final inputDialogModel = InputDialogModel(
  //     title: title,
  //     message: message,
  //     onCancel: onCancelAction,
  //     onConfirm: onConfirmAction,
  //     maxLength: maxLength,
  //     dismissOnTapOutside: dismissOnTapOutside,
  //     initialValue: initialValue,
  //   );

  //   router.push(InputDialogRoute(model: inputDialogModel));
  // }

  @optionalTypeArgs
  Future<bool> pop<T extends Object?>([T? result]) async {
    return router.pop(result);
  }

  Future<T?> push<T extends Object?>({required String route, bool clearBackStack = false}) {
    if (clearBackStack) {
      router.popUntilRoot();
      return router.replaceNamed(route);
    } else {
      return router.pushNamed(
        route,
        onFailure: (failure) => log(
          failure.toString(),
        ),
      );
    }
  }

  // Pushes a AutoRoute
  Future<T?> pushRoute<T extends Object?>(PageRouteInfo route) {
    return router.push(route);
  }
}

final presentationServiceProvider = Provider<PresentationService>((ref) => PresentationService());
