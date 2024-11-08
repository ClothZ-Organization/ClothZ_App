// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:finding_clothes/src/shared/domain/loading_indicator_size.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_button.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_loading_indicator.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_text_action.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../application/login_view_model.dart';

@RoutePage()
class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModelProvider);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: Colors.black,
      body: viewModel.isLoading
          ? const Center(
              child: FCLoadingIndicator(
                size: LoadingIndicatorSize.standart,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height / 4,
                      width: double.infinity,
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/images/register_img.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            'WELCOME BACK',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 40.0,
                              height: 1.12,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          const Text(
                            'Join clothesx community today and find all the products you need',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                              height: 1.64,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FCTextField(
                            controller: emailController,
                            onChanged: viewModel.changeText,
                            hintText: 'Email',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FCTextField(
                            controller: passwordController,
                            onChanged: viewModel.changeText,
                            hintText: 'Password',
                            isObscureText: true,
                          ),
                          viewModel.isErrorLogIn
                              ? const SizedBox.shrink()
                              : textMessage(viewModel),
                          const SizedBox(
                            height: 28,
                          ),
                          Center(
                            child: FCButton(
                              onTap: () {
                                debugPrint('---${emailController.text}');
                                debugPrint('---${passwordController.text}');
                                viewModel.login(
                                    email: emailController.text,
                                    password: passwordController.text);
                              },
                              text: "Log In",
                              isWidthMax: true,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          orLine(),
                          const SizedBox(
                            height: 20,
                          ),
                          _googleSignInButton(
                            onPressed: () {
                              debugPrint('---dadad');
                              viewModel.loginWithGoogle();
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: FCTextAction(
                              text: 'Don’t have any account? ',
                              textAction: 'Register',
                              onTap: () {
                                debugPrint('---- go Register');
                                viewModel.goRegister();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget textMessage(final viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          viewModel.errorText,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.14,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget orLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            color: Colors.grey,
            height: 1,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const Text(
          'OR',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            color: Colors.grey,
            height: 1,
          ),
        ),
      ],
    );
  }

  Widget _googleSignInButton({required VoidCallback onPressed}) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: SizedBox(
          height: 49,
          width: double.infinity,
          child: SignInButton(
            Buttons.google,
            text: 'Sign up with Google',
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
