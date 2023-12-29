import 'package:path_to_regexp/path_to_regexp.dart';

extension RouteWithParameters on String {
  String withParams(Map<String, String> parameters) {
    final toPath = pathToFunction(this);
    return toPath(parameters);
  }
}