// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:finding_clothes/src/features/login/application/email_validation_view_model.dart';
import 'package:finding_clothes/src/features/login/domain/login_model.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_loading_indicator.dart';
import 'package:finding_clothes/src/shared/utils/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class EmailValidationPage extends ConsumerWidget {
  String email;
  String password;
  EmailValidationPage({
    super.key,
    @PathParam(RouteParameters.email) required this.email,
    @PathParam(RouteParameters.password) required this.password,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(
      emailValidationViewModel(
        LoginModel(email: email, password: password),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Email Validation',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontFamily: 'WorkSans',
            fontWeight: FontWeight.w600,
            fontSize: 22.0,
            height: 1.12,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          highlightColor: Colors.grey,
          iconSize: 22,
          icon: SvgPicture.asset(
            'lib/icons/arrow-back.svg',
            colorFilter:
                const ColorFilter.mode(Colors.white, BlendMode.srcATop),
            height: 22,
            width: 22,
          ),
          onPressed: () async {
            debugPrint('Pressed Back.');
            await viewModel.backAction();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            const Center(
              child: FCLoadingIndicator(),
            ),
            const Spacer(),
            const Text(
              'Check your email address ',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.w300,
                fontSize: 20.0,
                height: 1.12,
                color: Colors.white,
              ),
            ),
             Text(
              viewModel.getEmail(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: const TextStyle(
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
                height: 1.12,
                color: Colors.white,
              ),
            ),
             const Text(
              ' and access the link to validate your email and complete the registration.',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.w300,
                fontSize: 20.0,
                height: 1.12,
                color: Colors.white,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
