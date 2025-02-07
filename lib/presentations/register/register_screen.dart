import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/core/common_widgets/tap_out_widget.dart';
import 'package:flutter_interview_application/core/utils/validator_utils.dart';
import 'package:flutter_interview_application/presentations/register/register_cubit.dart';

import '../../core/common_widgets/email_text_form_field.dart';
import '../../core/common_widgets/password_text_form_field.dart';
import '../login/login_screen.dart';

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
  final TextEditingController _confirmPasswordController = TextEditingController();

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
      create: (context) => RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text("Register")),
        body: TapOutWidget(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  EmailTextFormField(controller: _emailController),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "Name"),
                    keyboardType: TextInputType.name,
                    validator: ValidatorUtils.name,
                  ),
                  const SizedBox(height: 12),
                  PasswordTextFormField(controller: _passwordController),
                  const SizedBox(height: 12),
                  PasswordTextFormField(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    validator: ValidatorUtils.password,
                  ),
                  SizedBox(height: 20),
                  BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSuccess) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                      } else if (state is RegisterError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    builder: (context, state) {
                      if (state is RegisterLoading) {
                        return CircularProgressIndicator();
                      }
                      return ElevatedButton(onPressed: () => _register(context), child: Text("Register"));
                    },
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
