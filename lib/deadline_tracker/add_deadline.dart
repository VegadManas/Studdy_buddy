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
    return Scaffold(
      // Gradient AppBar
      appBar: AppBar(
        title: const Text(
          "Add Deadline",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE3F2FD), Color(0xFF90CAF9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),

      body: Container(
        color: Colors.white,
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
                  prefixIcon: const Icon(Icons.title, color: Color(0xFF64B5F6)),
                  filled: true,
                  fillColor: const Color(0xFFF5F9FF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
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
                  prefixIcon: const Icon(
                    Icons.description,
                    color: Color(0xFF64B5F6),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F9FF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
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
                  prefixIcon: const Icon(Icons.book, color: Color(0xFF64B5F6)),
                  filled: true,
                  fillColor: const Color(0xFFF5F9FF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Pick Date button
              ElevatedButton.icon(
                icon: const Icon(Icons.calendar_today),
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
                  backgroundColor: const Color(0xFF64B5F6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 24),

              // Save button with gradient
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF64B5F6), Color(0xFF1976D2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Save Deadline",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
