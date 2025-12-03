import 'package:final_l3/core/constants/routes_constants.dart';
import 'package:final_l3/core/constants/string_constants.dart';
import 'package:final_l3/core/di/di.dart';
import 'package:final_l3/core/helper_functions.dart';
import 'package:final_l3/core/themes/app_text_styles.dart';
import 'package:final_l3/core/themes/custom_elevated_button.dart';
import 'package:final_l3/presentation/features/login/bloc/login_bloc.dart';

import 'package:final_l3/presentation/features/login/widgets/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Di.di<LoginBloc>(),
      child: Scaffold(
        body: LoginBody(
          formKey: _formKey,
          emailController: emailController,
          passwordController: passwordController,
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginBody({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          HelperFunctions.showSnackBar(state.msg, context, isError: false);
          context.go(RoutesConstants.dashboardRoute);
        } else if (state is LoginError) {
          HelperFunctions.showSnackBar(state.msg, context, isError: true);
        }
      },
      builder: (context, state) {
        final obscure = state is ObscuredState ? state.obscure : false;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              Text(
                StringConstants.signInLabel,
                style: const TextStyle(fontSize: 32),
              ),

              CustomForm(
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController,
                obscurePassword: obscure,
                onPasswordVisibilityToggle: () {
                  context.read<LoginBloc>().add(ObscureEvent());
                },
              ),

              CustomElevatedButton(
                isLoading: state is Loginloading,
                label: StringConstants.signInLabel,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(
                      LoginClicked(
                        email: emailController.text.trim(),
                        pass: passwordController.text.trim(),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  context.push(RoutesConstants.registerRoute);
                },
                child: Text(
                  StringConstants.dontHaveAnAccount,
                  style: AppTextStyles.bodyLarge,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
