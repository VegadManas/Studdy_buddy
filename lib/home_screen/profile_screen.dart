import 'package:flutter/material.dart';
import 'package:studdy_buddy/home_screen/settingscreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Helper method to build option cards
  Widget _buildOptionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      // --- CHANGE: Set elevation to 0 to remove shadow
      elevation: 0,
      // --- CHANGE: Card color uses theme surface
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        // --- CHANGE: Icon color uses theme primary
        leading: Icon(icon, color: colorScheme.primary),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            // --- CHANGE: Text color uses theme onSurface
            color: colorScheme.onSurface,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          // --- CHANGE: Trailing icon color uses theme onSurfaceVariant for muted look
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
      // --- CHANGE: Background color uses theme background
      backgroundColor: colorScheme.background,

      // --- CHANGE: Replaced PreferredSize/Container with simple AppBar (no gradient/shadow)
      appBar: AppBar(
        // AppBar color uses theme primary
        backgroundColor: colorScheme.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            // --- CHANGE: Text color uses theme onPrimary (for text on primary background)
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
                // --- CHANGE: Text color uses theme onSurface
                color: colorScheme.onSurface,
              ),
            ),
          ),
          Center(
            child: Text(
              'john.doe@example.com',
              style: TextStyle(
                fontSize: 14,
                // --- CHANGE: Secondary text color uses theme onSurfaceVariant
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 30),
          _buildOptionCard(
            context, // Passing context
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
            context, // Passing context
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              // Add logout logic
            },
          ),
        ],
      ),
    );
  }
}
