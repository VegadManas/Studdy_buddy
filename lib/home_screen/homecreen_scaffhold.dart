import 'package:flutter/material.dart';
import 'package:studdy_buddy/Time_table_viewer/screen/timetable_list_screen.dart';
import 'package:studdy_buddy/deadline_tracker/deadline_list.dart';
import 'package:studdy_buddy/gpa_calculator/gpa_screen.dart';
import 'package:studdy_buddy/material_screen/material_screen.dart';

class HomecreenScaffhold extends StatelessWidget {
  const HomecreenScaffhold({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the color scheme for theme-aware colors
    final colorScheme = Theme.of(context).colorScheme;

    void navigateTo(BuildContext context, String pageName) {
      if (pageName == 'Deadline Tracker') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DeadlineListScreen()),
        );
      } else if (pageName == "Timetable Viewer") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TimetableListScreen()),
        );
      } else if (pageName == "GPA Calculator") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GpaCalculator()),
        );
      } else if (pageName == "Study Materials") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MaterialScreen()),
        );
      }
    }

    const double spacing = 16.0;
    const double borderRadius = 20.0;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth =
        (screenWidth - (3 * spacing)) /
        2; // Adjusted for better responsiveness on smaller screens

    final List<Map<String, dynamic>> cardData = [
      {
        'title': 'Timetable Viewer',
        'icon': Icons.calendar_today,
        'route': 'Timetable Viewer',
      },
      {
        'title': 'Deadline Tracker',
        'icon': Icons.alarm,
        'route': 'Deadline Tracker',
      },
      {
        'title': 'Study Materials',
        'icon': Icons.folder_open,
        'route': 'Study Materials',
      },
      {
        'title': 'GPA Calculator',
        'icon': Icons.calculate,
        'route': 'GPA Calculator',
      },
    ];

    return Scaffold(
      // The Scaffold will use the theme's background color (scaffoldBackgroundColor)
      body: Container(
        // --- CHANGE: Removed LinearGradient, Container now uses the theme's background color
        color: colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.all(spacing),
          child: Align(
            alignment: Alignment.topCenter,
            child: Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: cardData.map((card) {
                return _buildCard(
                  context,
                  title: card['title'],
                  icon: card['icon'],
                  onTap: () => navigateTo(context, card['route']),
                  width: cardWidth,
                  borderRadius: borderRadius,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildCard(
  BuildContext context, {
  required String title,
  required IconData icon,
  required VoidCallback onTap,
  required double width,
  required double borderRadius,
}) {
  final colorScheme = Theme.of(context).colorScheme;

  return InkWell(
    onTap: onTap,
    child: Container(
      height: 220,
      width: width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        // --- CHANGE: Card background color is now theme surface (e.g., white in light mode)
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          // --- CHANGE: Border color is now a theme-aware muted color (onSurface for contrast)
          color: colorScheme.onSurface.withOpacity(
            0.3,
          ), // Using opacity for subtle border
          width: 3,
        ),
        // --- CHANGE: BoxShadow list removed to eliminate card shadow.
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // --- CHANGE: Icon circle color is now theme's primary color
              color: colorScheme.primary,
            ),
            // --- CHANGE: Icon color is now theme's onPrimary (text/icons on primary color)
            child: Icon(icon, size: 32, color: colorScheme.onPrimary),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              // --- CHANGE: Text color is now theme's onSurface (standard text color)
              color: colorScheme.onSurface,
              // --- CHANGE: Shadows list removed to eliminate text shadow.
            ),
          ),
        ],
      ),
    ),
  );
}
