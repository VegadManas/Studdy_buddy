import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studdy_buddy/Time_table_viewer/models/timetable_documet.dart';
import '../widgets/pdf_viewer_dialog.dart';

class TimetableListScreen extends StatefulWidget {
  const TimetableListScreen({super.key});

  @override
  State<TimetableListScreen> createState() => _TimetableListScreenState();
}

class _TimetableListScreenState extends State<TimetableListScreen> {
  List<TimetableDocument> documents = [];
  late Box _timetableBox; // ✅ Step 1: Hive box reference

  @override
  void initState() {
    super.initState();
    _timetableBox = Hive.box("timetableBox"); // ✅ Step 2: open the box
    _loadDocuments(); // ✅ Step 3: load existing saved data
  }

  // ✅ Step 4: Load previously saved timetables from Hive
  void _loadDocuments() {
    final data = _timetableBox.values.toList();
    setState(() {
      documents = data.map((item) {
        return TimetableDocument.fromMap(Map<String, dynamic>.from(item));
      }).toList();
    });
  }

  // ✅ Step 5: Save new timetable to Hive
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
        subtitle: "Size: ${(file.size / 1024).toStringAsFixed(1)} KB",
        filePath: file.path!,
      );

      setState(() {
        documents.add(newDoc);
      });

      // ✅ Save to Hive
      _timetableBox.put(newDoc.id, newDoc.toMap());
    }
  }

  // unchanged: dialog for description input
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
            child: Text(
              "Cancel",
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text("Save", style: TextStyle(color: colorScheme.primary)),
          ),
        ],
      ),
    );
  }

  // ✅ Step 6: Delete both from UI & Hive
  void _deleteDocument(String id) {
    setState(() {
      documents.removeWhere((doc) => doc.id == id);
    });
    _timetableBox.delete(id);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Timetable Viewer"),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      backgroundColor: colorScheme.background,
      body: documents.isEmpty
          ? Center(
              child: Text(
                "No timetables yet.\nTap the + button to add one.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
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
                        color: colorScheme.error,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 30),
                      child: Icon(
                        Icons.delete,
                        color: colorScheme.onError,
                        size: 30,
                      ),
                    ),
                    onDismissed: (_) => _deleteDocument(doc.id),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: colorScheme.onSurface.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          backgroundColor: colorScheme.primary,
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        title: Text(
                          doc.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        subtitle: Text(
                          doc.subtitle,
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.visibility,
                            color: colorScheme.primary,
                          ),
                          onPressed: () => showPdfViewerDialog(
                            context,
                            doc.filePath,
                            doc.title,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colorScheme.primary,
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
