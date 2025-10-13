import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/theme_provider.dart';

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
      elevation: 0,
      color: colorScheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: colorScheme.primary),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    ); // ✅ Access theme provider

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Settings",
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
              value: themeProvider.isDarkMode, // ✅ uses current theme state
              onChanged: (val) =>
                  themeProvider.toggleTheme(val), // ✅ updates theme
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
