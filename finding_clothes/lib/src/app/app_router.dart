import 'package:auto_route/auto_route.dart';

// AutoRouter generator generates a .gr.dart file so in order to keep the .g.dart convention,
// the generated code from the .gr.dart file can be copy/pasted in the app_router.g.dart and the
// .gr.dart file can be subsequently removed.
import '../shared/utils/constants/routes.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  late final String homeRoute;
  AppRouter(bool isAuthenticated) {
    homeRoute = isAuthenticated ?
Routes.dashboard
        : Routes.login;
  }
  @override
  List<AutoRoute> get routes => [
        RedirectRoute(path: Routes.initial, redirectTo: homeRoute),
        AutoRoute(page: LoginRoute.page, path: Routes.login),
        AutoRoute(page: RegisterRoute.page, path: Routes.register),
        AutoRoute(page: DashboardRoute.page, path: Routes.dashboard),
      ];
}
