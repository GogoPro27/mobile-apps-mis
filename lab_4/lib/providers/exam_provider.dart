import 'package:flutter/foundation.dart';
import 'package:lab4/models/exam_event.dart';

class ExamProvider extends ChangeNotifier {
  final List<ExamEvent> _exams = [];

  List<ExamEvent> get exams => [..._exams];

  void addExam(ExamEvent exam) {
    _exams.add(exam);
    notifyListeners();
  }
}