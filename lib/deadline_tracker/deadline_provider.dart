import 'package:flutter/material.dart';
import 'deadline_model.dart';

class DeadlineProvider extends ChangeNotifier {
  final List<Deadline> _deadlines = [];

  List<Deadline> get deadlines => _deadlines;

  void addDeadline(Deadline deadline) {
    _deadlines.add(deadline);
    notifyListeners();
  }

  void removeDeadline(int index) {
    _deadlines.removeAt(index);
    notifyListeners();
  }
}
