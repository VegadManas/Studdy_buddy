import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'deadline_provider.dart';
import 'add_deadline.dart';
// Note: Assumes the application's root widget is wrapped with a Theme.

class DeadlineListScreen extends StatelessWidget {
  const DeadlineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deadlineProvider = Provider.of<DeadlineProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Scaffold(
        // The Scaffold background color is handled by theme.scaffoldBackgroundColor

        // AppBar uses the settings from lightTheme()
        appBar: AppBar(
          title: const Text("Deadline Tracker"),
          centerTitle: true,
          // Removed flexibleSpace/gradient and explicit style, relying on AppBarTheme
          // defined in theme.dart for colors (AppColors.lightPrimary and white foreground).
        ),

        body: deadlineProvider.deadlines.isEmpty
            ? Center(
                child: Text(
                  "No deadlines yet. Add one!",
                  // Uses the secondary text style defined in the theme
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: deadlineProvider.deadlines.length,
                itemBuilder: (context, index) {
                  final deadline = deadlineProvider.deadlines[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: colorScheme
                          .surface, // Uses AppColors.lightSurface (White)
                      borderRadius: BorderRadius.circular(16),
                      // Using a light border color for a clean look
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 0.8,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Leading Icon with primary color background
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: colorScheme
                                  .primary, // Uses AppColors.lightPrimary (Indigo)
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.assignment_outlined,
                              color: colorScheme
                                  .onPrimary, // Uses Theme onPrimary (White)
                              size: 28,
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Title + Subtitle
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  deadline.title,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontSize: 18,
                                    // Color handled by theme.textTheme.titleLarge (AppColors.lightTextPrimary)
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  deadline.subject,
                                  // Color handled by theme.textTheme.bodyMedium (AppColors.lightTextSecondary)
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                    // Keep it explicitly grey to stand out less than title
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Due: ${deadline.dueDate.toLocal().toString().split(' ')[0]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme
                                        .error, // Uses AppColors.lightError (Red) for urgency
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Delete Button
                          IconButton(
                            icon: Icon(
                              Icons.delete_forever_rounded,
                              color: colorScheme
                                  .error, // Uses AppColors.lightError (Red)
                              size: 28,
                            ),
                            onPressed: () {
                              deadlineProvider.removeDeadline(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

        // Bottom Navigation Bar
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.primary, // Uses AppColors.lightPrimary (Indigo)
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddDeadlineScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  colorScheme.surface, // Uses AppColors.lightSurface (White)
              foregroundColor:
                  colorScheme.onSurface, // Text/icon color against the surface
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                // Border uses a shade of the primary color
                side: BorderSide(
                  color: colorScheme.primary.withOpacity(0.5),
                  width: 1.2,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            icon: Icon(Icons.add, color: colorScheme.onSurface),
            label: Text(
              "Add New Deadline",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
