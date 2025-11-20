import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:priority_matrix/core/theme/app_theme.dart';
import 'package:priority_matrix/data/datasources/task_local_datasource.dart';
import 'package:priority_matrix/presentation/providers/task_providers.dart';
import 'package:priority_matrix/presentation/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final dataSource = TaskLocalDataSource();
  await dataSource.init();

  runApp(
    ProviderScope(
      overrides: [
        taskLocalDataSourceProvider.overrideWithValue(dataSource),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Priority Matrix',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
