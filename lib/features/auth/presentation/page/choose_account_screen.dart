import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_application/core/base/base_status.dart';
import 'package:flutter_interview_application/core/models/user.dart';
import 'package:flutter_interview_application/dependency_injection/dependency_injection.dart';
import 'package:flutter_interview_application/features/auth/presentation/page/login_screen.dart';

import '../../../main/main_screen.dart';
import '../controller/choose_account_cubit.dart';

class ChooseAccountScreen extends StatefulWidget {
  const ChooseAccountScreen({super.key, required this.users});

  final List<User> users;

  @override
  State<ChooseAccountScreen> createState() => _ChooseAccountScreenState();
}

class _ChooseAccountScreenState extends State<ChooseAccountScreen> {
  final _chooseAccountCubit = getIt<ChooseAccountCubit>();

  @override
  void initState() {
    _chooseAccountCubit.init(widget.users);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _chooseAccountCubit,
      child: Scaffold(
        appBar: AppBar(
          title: FlutterLogo(
            size: 40,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Text('Choose an account', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 20),
                BlocConsumer<ChooseAccountCubit, ChooseAccountState>(
                  listener: (context, state) {
                    if (state.status.isSuccess) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const MainScreen()),
                        (route) => false,
                      );
                    } else if (state.status.isError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error.toString())));
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        for (int i = 0; i < state.accounts.length; i++)
                          ListTile(
                            title: Text(state.accounts[i].user.name),
                            trailing: state.accounts[i].isExpired
                                ? const Text(
                                    '(Session expired)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            leading: CircleAvatarWithRandomColorWidget(
                              index: i,
                              child: Text(state.accounts[i].user.name[0]),
                            ),
                            onTap: () {
                              if (state.accounts[i].isExpired) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen(
                                            user: state.accounts[i].user,
                                          )),
                                );
                              } else {
                                BlocProvider.of<ChooseAccountCubit>(context).selectUser(state.accounts[i]);
                              }
                            },
                          ),
                        ListTile(
                          title: Text('Add another account'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(Icons.person_add_alt),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                          },
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircleAvatarWithRandomColorWidget extends StatelessWidget {
  const CircleAvatarWithRandomColorWidget({super.key, required this.child, required this.index});

  final Widget child;
  final int index;

  static const List<Color> colors = [
    Color(0xFFE57373),
    Color(0xFF81C784),
    Color(0xFF64B5F6),
    Color(0xFFFFD54F),
    Color(0xFF9575CD),
    Color(0xFFFF8A65),
    Color(0xFF4DB6AC),
  ];

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: colors[index % colors.length],
      child: child,
    );
  }
}
