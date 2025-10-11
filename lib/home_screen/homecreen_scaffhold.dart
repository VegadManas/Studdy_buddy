import 'package:flutter/material.dart';
import 'package:studdy_buddy/deadline_tracker/deadline_list.dart';

class HomecreenScaffhold extends StatelessWidget {
  const HomecreenScaffhold({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateTo(BuildContext context, String pageName) {
      if (pageName == 'Deadline Tracker') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DeadlineListScreen()),
        );
      }
      // Add more if-else for other modules later (Timetable, GPA, etc.)
    }

    const double spacing = 16.0;
    const double borderRadius = 20.0;

    final double screenWidth = MediaQuery.of(context).size.width;

    // 🔹 make cards smaller from sides
    final double cardWidth = (screenWidth - (5 * spacing)) / 2;

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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(spacing),
          child: Center(
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
      body: Padding(
        padding: const EdgeInsets.all(spacing),
        // 🔹 move cards UP instead of center
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
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 220, // 🔹 slightly smaller height
      width: width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(borderRadius),
        // 🔹 add thick border
        border: Border.all(color: const Color.fromARGB(146, 0, 0, 0), width: 3),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 3)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 135, 197, 248), // soft blue
            ),
            child: Icon(
              icon,
              size: 32,
              color: Colors.white,
            ), // 🔹 adjusted size
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14, // 🔹 adjusted font size for smaller card
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 0, 0, 0), // deep blue text
              shadows: [
                Shadow(
                  color: Color.fromARGB(31, 0, 0, 0),
                  blurRadius: 1,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
