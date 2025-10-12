// lib/deadline_tracker/deadline_provider.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'deadline_model.dart';

class DeadlineProvider extends ChangeNotifier {
  static const _boxName = 'deadlinesBox';
  static const _listKey = 'deadlinesList';

  final Box _box = Hive.box(_boxName);
  final List<Deadline> _deadlines = [];

  DeadlineProvider() {
    _loadDeadlines();
  }

  List<Deadline> get deadlines => List.unmodifiable(_deadlines);

  void _loadDeadlines() {
    final stored = _box.get(_listKey, defaultValue: []);
    if (stored is List) {
      _deadlines.clear();
      try {
        for (final item in stored) {
          if (item is Map) {
            _deadlines.add(Deadline.fromMap(Map<dynamic, dynamic>.from(item)));
          }
        }
      } catch (e) {
        // If parsing fails, ignore invalid entries.
      }
    }
    notifyListeners();
  }

  Future<void> addDeadline(Deadline d) async {
    _deadlines.add(d);
    await _saveAll();
    notifyListeners();
  }

  Future<void> removeDeadline(int index) async {
    if (index >= 0 && index < _deadlines.length) {
      _deadlines.removeAt(index);
      await _saveAll();
      notifyListeners();
    }
  }

  Future<void> _saveAll() async {
    final List<Map<String, dynamic>> serializable = _deadlines
        .map((d) => d.toMap())
        .toList();
    await _box.put(_listKey, serializable);
  }
}
