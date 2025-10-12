import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studdy_buddy/deadline_tracker/deadline_provider.dart';
import 'package:studdy_buddy/onboarding/onboarding.dart';
import 'package:studdy_buddy/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('deadlinesBox'); // single box we use

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DeadlineProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.light,
      home: const OnBoardingScreen(),
    );
  }
}
