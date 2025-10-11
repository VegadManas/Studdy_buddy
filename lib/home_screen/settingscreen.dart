import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // Helper method to build themed list tiles
  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      // --- CHANGE: Set elevation to 0 to remove shadow
      elevation: 0,
      // --- CHANGE: Card color uses theme surface
      color: colorScheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        // --- CHANGE: Icon color uses theme primary
        leading: Icon(icon, color: colorScheme.primary),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            // --- CHANGE: Title text color uses theme onSurface
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            // --- CHANGE: Subtitle text color uses theme onSurfaceVariant for muted look
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: trailing,
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
          "Settings",
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
          _buildTile(
            context,
            icon: Icons.person_outline,
            title: "Edit Profile",
            subtitle: "Change name, email or profile photo",
            onTap: () {},
          ),
          _buildTile(
            context,
            icon: Icons.dark_mode_outlined,
            title: "Dark Mode",
            subtitle: "Customize appearance",
            trailing: Switch(
              value: false,
              onChanged: (val) {},
              // Switch uses theme primary color by default but we ensure it's theme-aware
              activeColor: colorScheme.secondary,
            ),
          ),
          _buildTile(
            context,
            icon: Icons.notifications_none,
            title: "Notifications",
            subtitle: "Enable class and deadline alerts",
            onTap: () {},
          ),
          _buildTile(
            context,
            icon: Icons.cleaning_services_outlined,
            title: "Reset App Data",
            subtitle: "Clear all your timetable, GPA, and saved files",
            onTap: () {},
          ),
          _buildTile(
            context,
            icon: Icons.info_outline,
            title: "About App",
            subtitle: "ClassMate++ v1.0 by You",
            onTap: () {},
          ),
          _buildTile(
            context,
            icon: Icons.feedback_outlined,
            title: "Send Feedback",
            subtitle: "Report a bug or suggest features",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
