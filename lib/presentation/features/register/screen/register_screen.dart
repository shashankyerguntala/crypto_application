import 'package:final_l3/core/di/di.dart';
import 'package:final_l3/core/helper_functions.dart';
import 'package:final_l3/core/themes/custom_elevated_button.dart';
import 'package:final_l3/presentation/features/login/widgets/custom_text_field.dart';
import 'package:final_l3/presentation/features/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
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
      create: (_) => Di.di<RegisterBloc>(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                spacing: 16,
                children: [
                  const Text('Sign Up', style: TextStyle(fontSize: 32)),

                  Form(
                    key: formKey,
                    child: Column(
                      spacing: 16,
                      children: [
                        CustomTextField(
                          controller: emailController,
                          label: 'Email',
                          validator: HelperFunctions.validateEmail,
                        ),

                        BlocBuilder<RegisterBloc, RegisterState>(
                          buildWhen: (prev, curr) => curr is Obscured,
                          builder: (context, state) {
                            final obscure = state is Obscured
                                ? state.obscure
                                : true;

                            return CustomTextField(
                              controller: passwordController,
                              label: 'Password',
                              isPassword: true,
                              obscureText: obscure,
                              validator: HelperFunctions.validatePassword,
                              suffixIcon: IconButton(
                                onPressed: () => context
                                    .read<RegisterBloc>()
                                    .add(TogglePass()),
                                icon: Icon(
                                  obscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  BlocBuilder<RegisterBloc, RegisterState>(
                    buildWhen: (prev, curr) =>
                        curr is RegisterLoading || curr is RegisterError,
                    builder: (context, state) {
                      return CustomElevatedButton(
                        label: 'Sign Up',
                        isLoading: state is RegisterLoading,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            context.read<RegisterBloc>().add(
                              RegisterClicked(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),

                  BlocListener<RegisterBloc, RegisterState>(
                    listenWhen: (_, curr) => curr is RegisterSuccess,
                    listener: (context, state) {
                      if (state is RegisterSuccess) {
                        HelperFunctions.showSnackBar(
                          '',
                          context,
                          isError: false,
                        );
                      }
                    },
                    child: const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
