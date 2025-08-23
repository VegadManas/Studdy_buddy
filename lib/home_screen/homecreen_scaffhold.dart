import 'package:flutter/material.dart';

class HomecreenScaffhold extends StatelessWidget {
  const HomecreenScaffhold({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateTo(BuildContext context, String pageName) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Navigate to $pageName screen')));
    }

    const double spacing = 16.0;
    const double borderRadius = 20.0;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = (screenWidth - (3 * spacing)) / 2;

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
      height: 220,
      width: width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFFFFF), // White
            Color(0xFFE3F2FD), // Very light blue
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 3)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 135, 197, 248), // soft blue
            ),
            child: Icon(icon, size: 36, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
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
