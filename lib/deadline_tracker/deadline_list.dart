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
      appBar: AppBar(title: const Text("Deadlines")),
      body: ListView.builder(
        itemCount: deadlineProvider.deadlines.length,
        itemBuilder: (context, index) {
          final deadline = deadlineProvider.deadlines[index];
          return ListTile(
            title: Text(deadline.title),
            subtitle: Text(
              "${deadline.subject} | Due: ${deadline.dueDate.toLocal()}".split(
                ' ',
              )[0],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                deadlineProvider.removeDeadline(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddDeadlineScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
