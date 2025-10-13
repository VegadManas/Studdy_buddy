import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studdy_buddy/deadline_tracker/deadline_provider.dart';
import 'package:studdy_buddy/home_screen/home_screen.dart';
import 'package:studdy_buddy/onboarding/onboarding.dart';
import 'package:studdy_buddy/theme.dart';
import 'package:studdy_buddy/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('deadlinesBox');
  await Hive.openBox("timetableBox");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeadlineProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _hasSeenOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('seenOnboarding') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      // ✅ Use provider’s state instead of ThemeMode.system
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: FutureBuilder<bool>(
        future: _hasSeenOnboarding(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.data! ? const HomeScreen() : const OnBoardingScreen();
        },
      ),
    );
  }
}
