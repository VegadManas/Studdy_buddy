import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFBBDEFB), Color(0xFFE3F2FD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "Settings",
              style: TextStyle(
                color: Color.fromARGB(255, 37, 35, 35),
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTile(
            icon: Icons.person_outline,
            title: "Edit Profile",
            subtitle: "Change name, email or profile photo",
            onTap: () {},
          ),
          _buildTile(
            icon: Icons.dark_mode_outlined,
            title: "Dark Mode",
            subtitle: "Customize appearance",
            trailing: Switch(value: false, onChanged: (val) {}),
          ),
          _buildTile(
            icon: Icons.notifications_none,
            title: "Notifications",
            subtitle: "Enable class and deadline alerts",
            onTap: () {},
          ),
          _buildTile(
            icon: Icons.cleaning_services_outlined,
            title: "Reset App Data",
            subtitle: "Clear all your timetable, GPA, and saved files",
            onTap: () {},
          ),
          _buildTile(
            icon: Icons.info_outline,
            title: "About App",
            subtitle: "ClassMate++ v1.0 by You",
            onTap: () {},
          ),
          _buildTile(
            icon: Icons.feedback_outlined,
            title: "Send Feedback",
            subtitle: "Report a bug or suggest features",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
