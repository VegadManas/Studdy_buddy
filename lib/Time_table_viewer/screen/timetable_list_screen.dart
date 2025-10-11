import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:studdy_buddy/Time_table_viewer/models/timetable_documet.dart';
import '../widgets/pdf_viewer_dialog.dart';

class TimetableListScreen extends StatefulWidget {
  const TimetableListScreen({super.key});

  @override
  State<TimetableListScreen> createState() => _TimetableListScreenState();
}

class _TimetableListScreenState extends State<TimetableListScreen> {
  List<TimetableDocument> documents = [];
  // Removed static const Color primaryBlue = Colors.blue;

  Future<void> _pickAndAddFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      String? description = await _getDescriptionFromUser(context);
      final file = result.files.single;

      final newDoc = TimetableDocument(
        id: DateTime.now().toString(),
        title: description?.isNotEmpty == true ? description! : file.name,
        subtitle:
            "File: ${file.name} • Size: ${(file.size / 1024).toStringAsFixed(1)} KB",
        filePath: file.path!,
      );

      setState(() {
        documents.add(newDoc);
      });
    }
  }

  Future<String?> _getDescriptionFromUser(BuildContext context) async {
    final controller = TextEditingController();
    final colorScheme = Theme.of(context).colorScheme;

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colorScheme.surface,
        title: Text(
          "Add Description",
          style: TextStyle(color: colorScheme.onSurface),
        ),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: "Enter timetable title/description",
            hintText: "e.g. CSE Sem 3 Time Table",
            labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
          style: TextStyle(color: colorScheme.onSurface),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            // Cancel uses muted color
            child: Text(
              "Cancel",
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            // Save uses theme primary color
            child: Text("Save", style: TextStyle(color: colorScheme.primary)),
          ),
        ],
      ),
    );
  }

  void _deleteDocument(String id) {
    setState(() {
      documents.removeWhere((doc) => doc.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Timetable Viewer"),
        centerTitle: true,
        // Using theme primary color and onPrimary for consistency
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      // Background color uses theme background
      backgroundColor: colorScheme.background,
      body: documents.isEmpty
          ? Center(
              child: Text(
                "No timetables yet.\nTap the + button to add one.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  // Text uses theme onSurfaceVariant for muted look
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final doc = documents[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Dismissible(
                    key: ValueKey(doc.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        // Delete background uses theme error color
                        color: colorScheme.error,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 30),
                      child: Icon(
                        Icons.delete,
                        // Delete icon uses theme onError color (white/light)
                        color: colorScheme.onError,
                        size: 30,
                      ),
                    ),
                    onDismissed: (_) => _deleteDocument(doc.id),
                    child: Container(
                      decoration: BoxDecoration(
                        // Item background uses theme surface
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(15),
                        // Subtle border using onSurface with low opacity
                        border: Border.all(
                          color: colorScheme.onSurface.withOpacity(0.1),
                          width: 1,
                        ),
                        // BoxShadow removed
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          // Avatar background uses theme primary
                          backgroundColor: colorScheme.primary,
                          child: Icon(
                            Icons.picture_as_pdf,
                            // PDF icon color uses theme onPrimary
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        title: Text(
                          doc.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // Title text color uses theme onSurface
                            color: colorScheme.onSurface,
                          ),
                        ),
                        subtitle: Text(
                          doc.subtitle,
                          // Subtitle text color uses theme onSurfaceVariant
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.visibility,
                            // Visibility icon color uses theme primary
                            color: colorScheme.primary,
                          ),
                          onPressed: () => showPdfViewerDialog(
                            context,
                            doc.filePath,
                            doc.title,
                            // Removed the colorScheme.primary argument
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        // FAB background uses theme primary
        backgroundColor: colorScheme.primary,
        // FAB icon/text color uses theme onPrimary
        icon: Icon(Icons.upload_file, color: colorScheme.onPrimary),
        label: Text(
          "Add Timetable",
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: _pickAndAddFile,
      ),
    );
  }
}
