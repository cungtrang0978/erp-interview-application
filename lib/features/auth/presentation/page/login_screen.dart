import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/core/base/base_status.dart';
import 'package:flutter_interview_application/core/common_widgets/common_elevated_button.dart';
import 'package:flutter_interview_application/core/common_widgets/email_text_form_field.dart';
import 'package:flutter_interview_application/core/common_widgets/remember_me_checkbox.dart';
import 'package:flutter_interview_application/core/common_widgets/tap_out_widget.dart';
import 'package:flutter_interview_application/features/auth/presentation/controller/login_cubit.dart';

import '../../../../../core/common_widgets/password_text_form_field.dart';
import '../../../../../core/models/user.dart';
import '../../../../../dependency_injection/dependency_injection.dart';
import '../../../main/main_screen.dart';
import '../widgets/social_button.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.user});

  final User? user;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginCubit = getIt<LoginCubit>();
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController =
      TextEditingController(text: widget.user?.email);
  final TextEditingController _passwordController = TextEditingController();
  late bool rememberMe = widget.user != null;

  void _logIn(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return; // Validate inputs

    BlocProvider.of<LoginCubit>(context).submit(
      _emailController.text.trim(),
      _passwordController.text,
      rememberMe,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginCubit,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back, color: Colors.black),
        //     onPressed: () => Navigator.pop(context),
        //   ),
        // ),
        body: SafeArea(
          child: TapOutWidget(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Welcome back',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    EmailTextFormField(controller: _emailController),
                    const SizedBox(height: 16),
                    PasswordTextFormField(controller: _passwordController),
                    const SizedBox(height: 8),
                    RememberMeCheckbox(
                      onChanged: (value) {
                        rememberMe = value;
                      },
                      initialValue: rememberMe,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: BlocConsumer<LoginCubit, LoginState>(
                          listener: (context, state) {
                            if (state.status.isSuccess) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => MainScreen()),
                                (route) => false,
                              );
                            } else if (state.status.isError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)));
                            }
                          },
                          buildWhen: (previous, current) =>
                              previous.status.isLoading !=
                              current.status.isLoading,
                          builder: (context, state) {
                            return CommonElevatedButton(
                              isLoading: state.status.isLoading,
                              onPressed: () => _logIn(context),
                              child: const Text("Log In"),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildRegisterWidget(context),
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

  Widget _buildRegisterWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const RegisterScreen()));
          },
          child: const Text('Register'),
        ),
      ],
    );
  }
}
