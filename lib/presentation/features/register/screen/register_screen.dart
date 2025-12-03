import 'package:final_l3/core/constants/routes_constants.dart';
import 'package:final_l3/core/constants/string_constants.dart';
import 'package:final_l3/core/di/di.dart';
import 'package:final_l3/core/helper_functions.dart';
import 'package:final_l3/core/themes/app_text_styles.dart';
import 'package:final_l3/core/themes/custom_elevated_button.dart';
import 'package:final_l3/presentation/features/login/widgets/custom_text_field.dart';
import 'package:final_l3/presentation/features/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
            child: BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisterError) {
                  HelperFunctions.showSnackBar(
                    state.msg,
                    context,
                    isError: true,
                  );
                }

                if (state is RegisterSuccess) {
                  HelperFunctions.showSnackBar(
                    StringConstants.userRegisteredSuccess,
                    context,
                    isError: false,
                  );
                  context.pop(RegisterScreen());
                }
              },
              builder: (context, state) {
                final bloc = context.read<RegisterBloc>();
                final obscure = state is Obscured ? state.obscure : true;

                return SingleChildScrollView(
                  child: Column(
                    spacing: 16,
                    children: [
                      Text(
                        StringConstants.signUp,
                        style: AppTextStyles.headlineLarge,
                      ),

                      Form(
                        key: formKey,
                        child: Column(
                          spacing: 16,
                          children: [
                            CustomTextField(
                              controller: emailController,
                              label: StringConstants.emailLabel,
                              validator: HelperFunctions.validateEmail,
                            ),

                            CustomTextField(
                              controller: passwordController,
                              label: StringConstants.passwordLabel,
                              obscureText: obscure,
                              isPassword: true,
                              validator: HelperFunctions.validatePassword,
                              suffixIcon: IconButton(
                                onPressed: () => bloc.add(TogglePass()),
                                icon: Icon(
                                  obscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.go(RoutesConstants.loginRoute),
                        child: Text(StringConstants.alreadyaUser),
                      ),
                      CustomElevatedButton(
                        label: StringConstants.signUp,
                        isLoading: state is RegisterLoading,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            bloc.add(
                              RegisterClicked(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
