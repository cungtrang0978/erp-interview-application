import 'package:flutter/material.dart';
import 'package:flutter_interview_application/core/common_widgets/common_elevated_button.dart';
import 'package:flutter_interview_application/core/common_widgets/common_outlined_button.dart';

import '../auth/presentation/page/choose_account_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.parentContext});
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      backgroundColor: Colors.white.withOpacity(0.6),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonOutlinedButton(height: 48, child: Text("Change Account"), onPressed: () {}),
            const SizedBox(height: 16),
            CommonElevatedButton(
                child: Text("Log Out"),
                onPressed: () {
                  Navigator.of(parentContext).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => ChooseAccountScreen()),
                    (route) => false,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
