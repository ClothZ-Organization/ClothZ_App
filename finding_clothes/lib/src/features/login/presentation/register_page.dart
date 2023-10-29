// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:finding_clothes/src/features/login/application/register_view_model.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_button.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_text_action.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(registerViewModelProvider);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: Colors.black,
      body: viewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF7C00FF)),
              ),
            )
          : MaterialApp(
              home: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
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
                              'START THE JOURNEY NOW',
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
                            const SizedBox(
                              height: 20,
                            ),
                            FCTextField(
                              controller: confirmPasswordController,
                              onChanged: viewModel.changeText,
                              hintText: 'Confirm Password',
                              isObscureText: true,
                            ),
                            const SizedBox(
                              height: 33,
                            ),
                            Center(
                              child: FCButton(
                                onTap: () {
                                  debugPrint('---${emailController.text}');
                                  debugPrint('---${passwordController.text}');
                                  debugPrint(
                                      '---${confirmPasswordController.text}');
                                  viewModel.register(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      passwordConfirm:
                                          confirmPasswordController.text);
                                },
                                text: "Register Now",
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: FCTextAction(
                                text: 'Already registered? ',
                                textAction: 'Log In',
                                onTap: () {
                                  debugPrint('----dadad LogIn');
                                  viewModel.goLogIn();
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
            ),
    );
  }
}
