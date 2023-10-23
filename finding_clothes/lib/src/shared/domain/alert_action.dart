
class AlertAction<T> {
  final String title;
  final Function() callback;

  AlertAction({
    required this.title,
    required this.callback,
  });
}

class InputAlertAction<T> {
  final String title;
  final Function(T) callback;

  InputAlertAction({
    required this.title,
    required this.callback,
  });
}