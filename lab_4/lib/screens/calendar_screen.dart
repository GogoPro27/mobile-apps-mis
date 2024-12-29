import 'package:flutter/material.dart';
import 'package:lab4/screens/map_screen.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lab4/providers/exam_provider.dart';
import 'package:lab4/screens/add_event_screen.dart';


class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exams = Provider.of<ExamProvider>(context).exams;

    return Scaffold(
      appBar: AppBar(title: const Text('Exam Schedule')),
      body: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        eventLoader: (date) {
          return exams.where((exam) {
            return exam.dateTime.year == date.year &&
                exam.dateTime.month == date.month &&
                exam.dateTime.day == date.day;
          }).toList();
        },
        onDaySelected: (selectedDay, focusedDay) {
          final selectedExams = exams.where((exam) {
            return exam.dateTime.year == selectedDay.year &&
                exam.dateTime.month == selectedDay.month &&
                exam.dateTime.day == selectedDay.day;
          }).toList();

          if (selectedExams.isNotEmpty) {
            showModalBottomSheet(
              context: context,
              builder: (_) => ListView.builder(
                itemCount: selectedExams.length,
                itemBuilder: (ctx, index) {
                  final exam = selectedExams[index];
                  return ListTile(
                    title: Text(exam.title),
                    subtitle: Text(exam.locationName),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => MapScreen(
                            initialLocation: exam.location,
                            isReadOnly: true, // Prevent selecting a new location
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-event');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}