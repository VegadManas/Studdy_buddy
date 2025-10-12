import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'deadline_model.dart';
import 'deadline_provider.dart';

class AddDeadlineScreen extends StatefulWidget {
  const AddDeadlineScreen({super.key});

  @override
  State<AddDeadlineScreen> createState() => _AddDeadlineScreenState();
}

class _AddDeadlineScreenState extends State<AddDeadlineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _subjectController = TextEditingController();
  DateTime? _selectedDate;

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final newDeadline = Deadline(
        title: _titleController.text,
        description: _descriptionController.text,
        subject: _subjectController.text,
        dueDate: _selectedDate!,
        // NOTE: Ensure your Deadline model supports this property if needed by the list screen
        // isCompleted: false,
      );

      Provider.of<DeadlineProvider>(
        context,
        listen: false,
      ).addDeadline(newDeadline);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      // AppBar (Theme-consistent, flat design)
      appBar: AppBar(
        title: Text(
          "Add Deadline",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimary, // Uses theme's onPrimary
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary, // Uses theme's primary
        elevation: 0, // Flat design
      ),

      body: Container(
        color: colorScheme.background, // Uses theme's background
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                  prefixIcon: Icon(
                    Icons.title,
                    color: colorScheme.primary,
                  ), // Icon uses theme primary
                  filled: true,
                  fillColor: colorScheme
                      .surfaceVariant, // Fill uses a light surface variant
                  // Custom border styling for flat look
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.outlineVariant,
                      width: 1,
                    ),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Please enter a title" : null,
              ),
              const SizedBox(height: 12),

              // Description field
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Description",
                  labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                  prefixIcon: Icon(
                    Icons.description,
                    color: colorScheme.primary,
                  ),
                  filled: true,
                  fillColor: colorScheme.surfaceVariant,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.outlineVariant,
                      width: 1,
                    ),
                  ),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),

              // Subject field
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(
                  labelText: "Subject",
                  labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                  prefixIcon: Icon(Icons.book, color: colorScheme.primary),
                  filled: true,
                  fillColor: colorScheme.surfaceVariant,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.outlineVariant,
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Pick Date button
              ElevatedButton.icon(
                icon: Icon(
                  Icons.calendar_today,
                  color: colorScheme.onSecondary,
                ),
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
                label: Text(
                  _selectedDate == null
                      ? "Pick a Date"
                      : "Due: ${_selectedDate!.toLocal().toString().split(' ')[0]}",
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      colorScheme.secondary, // Uses theme secondary
                  foregroundColor:
                      colorScheme.onSecondary, // Uses theme onSecondary
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 24),

              // Save button (Removed gradient container and used primary color)
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary, // Uses theme primary
                  foregroundColor:
                      colorScheme.onPrimary, // Uses theme onPrimary
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  "Save Deadline",
                  style: TextStyle(
                    color: colorScheme.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
