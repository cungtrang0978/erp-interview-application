import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/core/common_widgets/common_elevated_button.dart';
import 'package:flutter_interview_application/core/common_widgets/tap_out_widget.dart';
import 'package:flutter_interview_application/core/utils/validator_utils.dart';
import 'package:flutter_interview_application/dependency_injection/dependency_injection.dart';
import 'package:flutter_interview_application/features/auth/presentation/controller/register_cubit.dart';

import '../../../../../core/common_widgets/email_text_form_field.dart';
import '../../../../../core/common_widgets/password_text_form_field.dart';
import '../widgets/social_button.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    BlocProvider.of<RegisterCubit>(context).submit(
      _emailController.text.trim(),
      _passwordController.text,
      _nameController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
      child: Scaffold(
        // appBar: AppBar(title: Text("Register")),
        body: SafeArea(
          child: TapOutWidget(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  children: [
                    const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    EmailTextFormField(controller: _emailController),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: "Full Name"),
                      keyboardType: TextInputType.name,
                      validator: ValidatorUtils.name,
                    ),
                    const SizedBox(height: 16),
                    PasswordTextFormField(controller: _passwordController),
                    const SizedBox(height: 16),
                    PasswordTextFormField(
                      controller: _confirmPasswordController,
                      label: 'Confirm Password',
                      validator: (value) => ValidatorUtils.confirmPassword(
                          value, _passwordController.text),
                    ),
                    _checkBox(context),
                    SizedBox(height: 20),
                    BlocConsumer<RegisterCubit, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterSuccess) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => LoginScreen()));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Registration successful')));
                        } else if (state is RegisterError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)));
                        }
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: CommonElevatedButton(
                              isLoading: state is RegisterLoading,
                              onPressed: () => _register(context),
                              child: const Text("Register"),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account? '),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialButton(icon: Icons.facebook),
                        const SizedBox(width: 16),
                        SocialButton(icon: Icons.apple),
                        const SizedBox(width: 16),
                        SocialButton(icon: Icons.g_mobiledata),
                        const SizedBox(width: 16),
                        SocialButton(icon: Icons.telegram),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _checkBox(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey[600]),
            children: const [
              TextSpan(text: 'I agree to the processing of '),
              TextSpan(
                text: 'Personal data',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
