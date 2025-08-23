import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'deadline_provider.dart';
import 'add_deadline.dart';

class DeadlineListScreen extends StatelessWidget {
  const DeadlineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deadlineProvider = Provider.of<DeadlineProvider>(context);

    return Scaffold(
      // AppBar with gradient
      appBar: AppBar(
        title: const Text(
          "Deadline Tracker",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFE3F2FD), // very light blue
                Color(0xFFBBDEFB), // soft sky blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),

      // Background plain white
      body: Container(
        color: Colors.white,
        child: deadlineProvider.deadlines.isEmpty
            ? const Center(
                child: Text(
                  "No deadlines yet. Add one!",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: deadlineProvider.deadlines.length,
                itemBuilder: (context, index) {
                  final deadline = deadlineProvider.deadlines[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF90CAF9), // soft plain blue
                        ),
                        child: const Icon(
                          Icons.assignment,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        deadline.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        "${deadline.subject} | Due: ${deadline.dueDate.toLocal().toString().split(' ')[0]}",
                        style: const TextStyle(color: Colors.black87),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          deadlineProvider.removeDeadline(index);
                        },
                      ),
                    ),
                  );
                },
              ),
      ),

      // Floating Action Button with blue gradient
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFF64B5F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddDeadlineScreen()),
            );
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
