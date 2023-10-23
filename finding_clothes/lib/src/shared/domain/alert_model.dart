import 'alert_action.dart';

interface class BaseAlertModel {
  final String title;
  final String? message;
  final bool dismissOnTapOutside;

  BaseAlertModel({
    required this.title,
    this.dismissOnTapOutside = true,
    this.message,
  });
}

class AlertModel extends BaseAlertModel {
  AlertAction? onConfirm;
  AlertAction? onCancel;

  AlertModel({
    required super.title,
    super.message,
    super.dismissOnTapOutside,
    this.onConfirm,
    this.onCancel,
  });
}

class InputDialogModel extends BaseAlertModel {
  final String? initialValue;
  InputAlertAction<String> onConfirm;
  AlertAction? onCancel;
  int? maxLength;
  
  InputDialogModel({
    required super.title,
    required this.onConfirm,
    super.message,
    super.dismissOnTapOutside,
    this.initialValue,
    this.onCancel,
    this.maxLength,
  });
}
