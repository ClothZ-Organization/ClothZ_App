// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:finding_clothes/src/features/dashboard/presentation/dashboard_page.dart'
    as _i2;
import 'package:finding_clothes/src/features/login/presentation/email_validation_page.dart'
    as _i3;
import 'package:finding_clothes/src/features/login/presentation/login_page.dart'
    as _i5;
import 'package:finding_clothes/src/features/login/presentation/register_page.dart'
    as _i6;
import 'package:finding_clothes/src/features/subscrition/presentation/subscrition_page.dart'
    as _i7;
import 'package:finding_clothes/src/shared/domain/alert_model.dart' as _i10;
import 'package:finding_clothes/src/shared/presentation/widgets/dialogs/alert_dialog_page.dart'
    as _i1;
import 'package:finding_clothes/src/shared/presentation/widgets/full_screen_loading_indicator.dart'
    as _i4;
import 'package:flutter/material.dart' as _i9;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    AlertDialogRoute.name: (routeData) {
      final args = routeData.argsAs<AlertDialogRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AlertDialogPage(
          key: args.key,
          model: args.model,
        ),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.DashboardPage(),
      );
    },
    EmailValidationRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EmailValidationRouteArgs>(
          orElse: () => EmailValidationRouteArgs(
                email: pathParams.getString('email'),
                password: pathParams.getString('password'),
              ));
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.EmailValidationPage(
          key: args.key,
          email: args.email,
          password: args.password,
        ),
      );
    },
    FullScreenLoadingIndicatorRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.FullScreenLoadingIndicator(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.LoginPage(key: args.key),
      );
    },
    RegisterRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterRouteArgs>(
          orElse: () => const RegisterRouteArgs());
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.RegisterPage(key: args.key),
      );
    },
    SubscritionRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SubscritionPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AlertDialogPage]
class AlertDialogRoute extends _i8.PageRouteInfo<AlertDialogRouteArgs> {
  AlertDialogRoute({
    _i9.Key? key,
    required _i10.AlertModel model,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          AlertDialogRoute.name,
          args: AlertDialogRouteArgs(
            key: key,
            model: model,
          ),
          initialChildren: children,
        );

  static const String name = 'AlertDialogRoute';

  static const _i8.PageInfo<AlertDialogRouteArgs> page =
      _i8.PageInfo<AlertDialogRouteArgs>(name);
}

class AlertDialogRouteArgs {
  const AlertDialogRouteArgs({
    this.key,
    required this.model,
  });

  final _i9.Key? key;

  final _i10.AlertModel model;

  @override
  String toString() {
    return 'AlertDialogRouteArgs{key: $key, model: $model}';
  }
}

/// generated route for
/// [_i2.DashboardPage]
class DashboardRoute extends _i8.PageRouteInfo<void> {
  const DashboardRoute({List<_i8.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.EmailValidationPage]
class EmailValidationRoute extends _i8.PageRouteInfo<EmailValidationRouteArgs> {
  EmailValidationRoute({
    _i9.Key? key,
    required String email,
    required String password,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          EmailValidationRoute.name,
          args: EmailValidationRouteArgs(
            key: key,
            email: email,
            password: password,
          ),
          rawPathParams: {
            'email': email,
            'password': password,
          },
          initialChildren: children,
        );

  static const String name = 'EmailValidationRoute';

  static const _i8.PageInfo<EmailValidationRouteArgs> page =
      _i8.PageInfo<EmailValidationRouteArgs>(name);
}

class EmailValidationRouteArgs {
  const EmailValidationRouteArgs({
    this.key,
    required this.email,
    required this.password,
  });

  final _i9.Key? key;

  final String email;

  final String password;

  @override
  String toString() {
    return 'EmailValidationRouteArgs{key: $key, email: $email, password: $password}';
  }
}

/// generated route for
/// [_i4.FullScreenLoadingIndicator]
class FullScreenLoadingIndicatorRoute extends _i8.PageRouteInfo<void> {
  const FullScreenLoadingIndicatorRoute({List<_i8.PageRouteInfo>? children})
      : super(
          FullScreenLoadingIndicatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'FullScreenLoadingIndicatorRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i8.PageInfo<LoginRouteArgs> page =
      _i8.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.RegisterPage]
class RegisterRoute extends _i8.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          RegisterRoute.name,
          args: RegisterRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i8.PageInfo<RegisterRouteArgs> page =
      _i8.PageInfo<RegisterRouteArgs>(name);
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.SubscritionPage]
class SubscritionRoute extends _i8.PageRouteInfo<void> {
  const SubscritionRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SubscritionRoute.name,
          initialChildren: children,
        );

  static const String name = 'SubscritionRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}
