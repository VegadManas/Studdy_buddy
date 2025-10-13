import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(home: GpaCalculator(), debugShowCheckedModeBanner: false),
  );
}

class GpaCalculator extends StatefulWidget {
  const GpaCalculator({super.key});

  @override
  State<GpaCalculator> createState() => _GpaCalculatorState();
}

class _GpaCalculatorState extends State<GpaCalculator> {
  final List<Subject> subjects = [Subject()];
  double totalGpa = 0.0;

  final gradePoints = {
    'O': 10,
    'A+': 9,
    'A': 8,
    'B+': 7,
    'B': 6,
    'C': 5,
    'F': 0,
  };

  final List<String> gradeOptions = ['O', 'A+', 'A', 'B+', 'B', 'C', 'F'];

  void addSubject() {
    setState(() => subjects.add(Subject()));
  }

  void removeSubject(int index) {
    if (subjects.length > 1) {
      setState(() => subjects.removeAt(index));
    }
  }

  void calculateGpa() {
    double totalPoints = 0;
    double totalCredits = 0;

    for (var sub in subjects) {
      final gradePoint = gradePoints[sub.grade] ?? 0;
      final credit = double.tryParse(sub.creditController.text) ?? 0;
      totalPoints += gradePoint * credit;
      totalCredits += credit;
    }

    setState(() {
      totalGpa = totalCredits == 0 ? 0 : totalPoints / totalCredits;
    });
  }

  void clearAll() {
    setState(() {
      subjects.clear();
      subjects.add(Subject());
      totalGpa = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Scaffold(
      backgroundColor: color.surface,
      appBar: AppBar(
        backgroundColor: color.primary,
        foregroundColor: color.onPrimary,
        title: const Text("GPA Calculator"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset All',
            onPressed: clearAll,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: color.primary,
        icon: const Icon(Icons.add),
        label: const Text("Add Subject"),
        onPressed: addSubject,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                "Enter your subjects, credits & grades",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: color.onSurface,
                ),
              ),
              const SizedBox(height: 14),

              // Subject cards
              ...subjects.asMap().entries.map((entry) {
                int i = entry.key;
                Subject sub = entry.value;
                return Card(
                  color: color.surfaceVariant,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: sub.nameController,
                                decoration: const InputDecoration(
                                  labelText: "Subject Name",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 1,
                              child: TextField(
                                controller: sub.creditController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Credits",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<String>(
                                value: sub.grade.isNotEmpty ? sub.grade : null,
                                items: gradeOptions.map((g) {
                                  return DropdownMenuItem(
                                    value: g,
                                    child: Text("$g (${gradePoints[g]})"),
                                  );
                                }).toList(),
                                decoration: const InputDecoration(
                                  labelText: "Grade",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (val) {
                                  setState(() => sub.grade = val ?? '');
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: subjects.length > 1
                                  ? () => removeSubject(i)
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Calculate button
              ElevatedButton.icon(
                onPressed: calculateGpa,
                icon: const Icon(Icons.calculate),
                label: const Text("Calculate GPA"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),
                  backgroundColor: color.primary,
                  foregroundColor: color.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 3,
                ),
              ),

              const SizedBox(height: 30),

              // Animated GPA result
              if (totalGpa > 0)
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 800),
                  tween: Tween(begin: 0, end: totalGpa),
                  builder: (context, value, child) => Column(
                    children: [
                      const Text(
                        "Your GPA is:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        value.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: color.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        getGpaRemark(value),
                        style: TextStyle(
                          color: value >= 8
                              ? Colors.green
                              : value >= 6
                              ? Colors.orange
                              : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  String getGpaRemark(double gpa) {
    if (gpa >= 9) return "Excellent 🎓";
    if (gpa >= 8) return "Very Good 💪";
    if (gpa >= 7) return "Good 👍";
    if (gpa >= 6) return "Average 🙂";
    return "Needs Improvement 😔";
  }
}

class Subject {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController creditController = TextEditingController();
  String grade = '';
}
