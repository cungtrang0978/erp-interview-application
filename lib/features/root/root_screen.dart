import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/dependency_injection/dependency_injection.dart';
import 'package:flutter_interview_application/features/root/root_cubit.dart';

import '../auth/presentation/page/choose_account_screen.dart';
import '../auth/presentation/page/login_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final rootCubit = getIt<RootCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      rootCubit.checkAccounts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => rootCubit,
      child: Scaffold(
        body: BlocListener<RootCubit, RootState>(
          listener: (context, state) {
            if (state is RootAccountsNotEmpty) {
              // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));

              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => ChooseAccountScreen(users: state.users)));
            } else if (state is RootNoAccounts) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
            }
          },
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
