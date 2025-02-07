import 'package:flutter/material.dart';
import 'package:flutter_interview_application/core/utils/flavor_settings.dart';
import 'package:flutter_interview_application/features/root/root_screen.dart';

import 'core/services/local_database_service.dart';
import 'core/services/remote_database_service.dart';

late final FlavorSettings flavorSettings;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  flavorSettings = await FlavorSettings.fromEnv();
  await RemoteDatabaseService.instance.init();
  await LocalDatabaseService.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter MySQL Auth',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: RootScreen(),
    );
  }
}
