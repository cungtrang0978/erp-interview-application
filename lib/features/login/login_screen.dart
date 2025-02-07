import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/core/base/base_status.dart';
import 'package:flutter_interview_application/core/common_widgets/email_text_form_field.dart';
import 'package:flutter_interview_application/core/common_widgets/remember_me_checkbox.dart';
import 'package:flutter_interview_application/core/common_widgets/tap_out_widget.dart';
import 'package:flutter_interview_application/features/login/login_cubit.dart';

import '../../core/common_widgets/password_text_form_field.dart';
import '../../core/models/user.dart';
import '../main/main_screen.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.user});

  final User? user;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController = TextEditingController(text: widget.user?.email);
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
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Log In")),
        body: TapOutWidget(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  EmailTextFormField(controller: _emailController),
                  const SizedBox(height: 12),
                  PasswordTextFormField(controller: _passwordController),
                  const SizedBox(height: 12),
                  RememberMeCheckbox(
                    onChanged: (value) {
                      rememberMe = value;
                    },
                    initialValue: rememberMe,
                  ),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state.status.isSuccess) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => MainScreen()),
                          (route) => false,
                        );
                      } else if (state.status.isError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    buildWhen: (previous, current) => previous.status.isLoading != current.status.isLoading,
                    builder: (context, state) {
                      if (state.status.isLoading) {
                        return CircularProgressIndicator();
                      }
                      return ElevatedButton(onPressed: () => _logIn(context), child: const Text("Log In"));
                    },
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                    child: const Text("Don't have an account? Register"),
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
