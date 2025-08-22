import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/deadline_tracker/deadline_provider.dart';

import 'package:studdy_buddy/onboarding/onboarding.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DeadlineProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OnBoardingScreen(), // No custom splash widget here
    );
  }
}
