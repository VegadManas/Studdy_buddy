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

  final List<Widget> screens = [
    const HomecreenScaffhold(),
    const ProfileScreen(),
  ];

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
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
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Ready to be productive today",
                      style: TextStyle(
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
            )
          : null, // No AppBar when on Profile tab (ProfileScreen has its own)

      body: IndexedStack(index: _currentIndex, children: screens),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorScheme.surface,
        elevation: 4,
        currentIndex: _currentIndex,
        onTap: _onTapped,
        selectedItemColor: colorScheme.primary,
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
