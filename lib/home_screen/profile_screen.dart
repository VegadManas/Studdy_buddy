import 'package:flutter/material.dart';
import 'package:studdy_buddy/home_screen/home_screen.dart';
import 'package:studdy_buddy/home_screen/settingscreen.dart';
// <-- Import your login page

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Simulated login state (you’ll replace this with real Firebase/Auth state later)
  final bool isLoggedIn = false;

  // Helper to build option cards
  Widget _buildOptionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: Icon(icon, color: colorScheme.primary),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, color: colorScheme.onSurface),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: colorScheme.onSurfaceVariant,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),

          // --- Show avatar & info if logged in ---
          if (isLoggedIn) ...[
            const Center(
              child: CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            Center(
              child: Text(
                'john.doe@example.com',
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ]
          // --- Otherwise show Login / Sign Up button ---
          else ...[
            Center(
              child: CircleAvatar(
                radius: 45,
                backgroundColor: colorScheme.primary.withOpacity(0.2),
                child: Icon(Icons.person, color: colorScheme.primary, size: 50),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Log In / Sign Up",
                  style: TextStyle(
                    color: colorScheme.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],

          const SizedBox(height: 30),

          // --- Always show other options ---
          _buildOptionCard(
            context,
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildOptionCard(
            context,
            icon: Icons.logout,
            title: isLoggedIn ? 'Logout' : 'Not logged in',
            onTap: () {
              if (isLoggedIn) {
                // TODO: Add logout logic
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("You are not logged in.")),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
