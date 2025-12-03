import 'package:final_l3/core/constants/string_constants.dart';
import 'package:final_l3/core/helper_functions.dart';
import 'package:final_l3/presentation/features/login/bloc/login_bloc.dart';
import 'package:final_l3/presentation/features/login/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onPasswordVisibilityToggle;
  final GlobalKey<FormState> formKey;

  const CustomForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onPasswordVisibilityToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: emailController,
            label: StringConstants.emailLabel,
            validator: HelperFunctions.validateEmail,
            isPassword: false,
          ),

          const SizedBox(height: 16),

          CustomTextField(
            controller: passwordController,
            label: StringConstants.passwordLabel,
            validator: HelperFunctions.validatePassword,
            isPassword: true,
            obscureText: context.read<LoginBloc>().obscure,
            suffixIcon: IconButton(
              onPressed: onPasswordVisibilityToggle,
              icon: Icon(
                obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
