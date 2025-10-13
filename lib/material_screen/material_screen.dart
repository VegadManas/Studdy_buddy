import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:open_file/open_file.dart';
import 'dart:convert';

void main() {
  runApp(const MaterialApp(home: MaterialScreen()));
}

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  _MaterialScreenState createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  final Map<String, List<File>> subjectFiles = {};
  final TextEditingController subjectController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSavedFiles();
  }

  // Load saved files from SharedPreferences
  Future<void> loadSavedFiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('subjectFiles');
    if (data != null) {
      Map<String, dynamic> jsonMap = jsonDecode(data);
      Map<String, List<File>> tempMap = {};
      for (var entry in jsonMap.entries) {
        String subject = entry.key;
        List<File> files = [];
        for (var path in entry.value) {
          File file = File(path);
          if (await file.exists()) {
            files.add(file);
          }
        }
        if (files.isNotEmpty) {
          tempMap[subject] = files;
        }
      }
      setState(() {
        subjectFiles.addAll(tempMap);
      });
    }
  }

  // Save current state to SharedPreferences
  Future<void> saveFiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, List<String>> tempMap = {};
    subjectFiles.forEach((subject, files) {
      tempMap[subject] = files.map((f) => f.path).toList();
    });
    await prefs.setString('subjectFiles', jsonEncode(tempMap));
  }

  // Add a new subject
  void addSubject() {
    String subjectName = subjectController.text.trim();
    if (subjectName.isEmpty) return;

    if (!subjectFiles.containsKey(subjectName)) {
      setState(() {
        subjectFiles[subjectName] = [];
      });
      subjectController.clear();
      saveFiles();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Subject already exists")));
    }
  }

  // Upload PDF to a subject
  Future<void> addFile(String subject) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      File pickedFile = File(result.files.single.path!);

      // Copy file to app directory
      Directory appDir = await getApplicationDocumentsDirectory();
      String newPath = '${appDir.path}/${pickedFile.path.split('/').last}';
      File savedFile = await pickedFile.copy(newPath);

      setState(() {
        if (subjectFiles.containsKey(subject)) {
          subjectFiles[subject]!.add(savedFile);
        } else {
          subjectFiles[subject] = [savedFile];
        }
      });

      await saveFiles();
    }
  }

  // Delete a file from a subject
  void removeFile(String subject, int index) async {
    File file = subjectFiles[subject]![index];
    if (await file.exists()) await file.delete();
    setState(() {
      subjectFiles[subject]!.removeAt(index);
    });
    await saveFiles();
  }

  // Delete an entire subject with confirmation
  Future<void> deleteSubject(String subject) async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text(
          "Are you sure you want to delete the subject \"$subject\" and all its files?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm) {
      // Delete all files in that subject
      for (File file in subjectFiles[subject]!) {
        if (await file.exists()) await file.delete();
      }

      // Remove subject from map
      setState(() {
        subjectFiles.remove(subject);
      });

      await saveFiles();
    }
  }

  // Open PDF file
  void openFile(File file) {
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Semester Materials"),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add Subject
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: subjectController,
                      decoration: const InputDecoration(
                        labelText: "New Subject",
                        hintText: "e.g. Physics",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: addSubject,
                    icon: const Icon(Icons.add),
                    label: const Text("Add Subject"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Display Subjects
              ...subjectFiles.entries.map((entry) {
                String subject = entry.key;
                List<File> files = entry.value;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Subject header with upload & delete buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              subject,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () => addFile(subject),
                                  icon: const Icon(Icons.upload_file),
                                  label: const Text("Upload PDF"),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => deleteSubject(subject),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ...files.asMap().entries.map((fileEntry) {
                          int index = fileEntry.key;
                          File file = fileEntry.value;
                          String name = file.path.split('/').last;
                          return ListTile(
                            leading: const Icon(
                              Icons.picture_as_pdf,
                              color: Colors.red,
                            ),
                            title: Text(name),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.open_in_new),
                                  onPressed: () => openFile(file),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => removeFile(subject, index),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
