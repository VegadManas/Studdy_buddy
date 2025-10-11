import 'package:flutter/material.dart';
import 'package:studdy_buddy/home_screen/homecreen_scaffhold.dart';
import 'package:studdy_buddy/home_screen/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> screens = [HomecreenScaffhold(), ProfileScreen()];

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(
      context,
    ).colorScheme; // Access color scheme once

    return Scaffold(
      // The AppBar now uses the solid colorScheme.primary defined in your theme.
      appBar: AppBar(
        // The background color is now a solid primary color from the theme.
        backgroundColor: colorScheme.primary,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Hello, User",
                style: TextStyle(
                  // --- KEEP: Using theme onPrimary (for text on the primary color background)
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                "Ready to be productive today",
                style: TextStyle(
                  // --- REVISED: Removed .withOpacity(0.8) to strictly use the theme color
                  color: colorScheme.onPrimary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _currentIndex = 1;
              });
            },
            icon: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
          ),
        ],
      ),

      body: IndexedStack(index: _currentIndex, children: screens),

      // The BottomNavigationBar now uses the solid colorScheme.surface defined in your theme.
      bottomNavigationBar: BottomNavigationBar(
        // The background color is now a solid surface color from the theme.
        backgroundColor: colorScheme.surface,
        elevation: 4,
        currentIndex: _currentIndex,
        onTap: _onTapped,
        // The selected item color should contrast the surface/background.
        selectedItemColor: colorScheme.primary,
        // The unselected item color should be the standard text color.
        unselectedItemColor: colorScheme.onSurface,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
