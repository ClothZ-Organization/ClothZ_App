// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:finding_clothes/src/features/login/application/register_view_model.dart';
import 'package:finding_clothes/src/shared/domain/loading_indicator_size.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_button.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_loading_indicator.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_text_action.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
      body: Stack(
        children: [
          IgnorePointer(
            ignoring: viewModel.isLoading,
            child: MaterialApp(
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
                        child: Form(
                          key: _formKey,
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
                                onChanged: viewModel.changeTextEmail,
                                hintText: 'Email',
                                isNotOk: viewModel.isNotOkEmail,
                                textIsNotOk: viewModel.textEmailIsNotOk,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FCTextField(
                                controller: passwordController,
                                onChanged: viewModel.changeTextPass1,
                                hintText: 'Password',
                                isObscureText: true,
                                isNotOk: viewModel.isNotOkPass,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FCTextField(
                                controller: confirmPasswordController,
                                onChanged: viewModel.changeTextPass2,
                                hintText: 'Confirm Password',
                                isObscureText: true,
                                isNotOk: viewModel.isNotOkPass,
                                textIsNotOk: viewModel.textPasswordIsNotOk,
                              ),
                              const SizedBox(
                                height: 28,
                              ),
                              Center(
                                child: FCButton(
                                  onTap: () async {
                                    debugPrint('---${emailController.text}');
                                    debugPrint('---${passwordController.text}');
                                    debugPrint(
                                        '---${confirmPasswordController.text}');
                                    await viewModel.register(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        passwordConfirm:
                                            confirmPasswordController.text);
                                    _formKey.currentState?.validate();
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (viewModel.isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: Center(
                  child: FCLoadingIndicator(
                    size: LoadingIndicatorSize.standart,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
