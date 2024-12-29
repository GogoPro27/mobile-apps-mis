import 'package:flutter/material.dart';
import 'package:lab4/screens/map_screen.dart';
import 'package:provider/provider.dart';
import 'package:lab4/providers/exam_provider.dart';
import 'package:lab4/models/exam_event.dart';
import 'package:latlong2/latlong.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  DateTime? _dateTime;
  LatLng? _location;
  String _locationName = '';

  void _selectLocation() async {
  final LatLng initialLocation = LatLng(42.0, 21.0); // Default location
  final LatLng? selectedLocation = await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => MapScreen(
        initialLocation: initialLocation,
        isReadOnly: false, // Allow selecting a new location
      ),
    ),
  );

  if (selectedLocation != null) {
    setState(() {
      _location = selectedLocation;
      _locationName = 'Selected Location'; // Replace with an actual name if needed
    });
  }
}

  void _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        _dateTime = pickedDate;
      });
    }
  }

  void _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        if (_dateTime != null) {
          _dateTime = DateTime(
            _dateTime!.year,
            _dateTime!.month,
            _dateTime!.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _location != null &&
        _dateTime != null) {
      _formKey.currentState!.save();
      Provider.of<ExamProvider>(context, listen: false).addExam(
        ExamEvent(
          id: DateTime.now().toString(),
          title: _title,
          dateTime: _dateTime!,
          location: _location!,
          locationName: _locationName,
        ),
      );
      Navigator.of(context).pop(); // Navigate back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Exam')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Exam Title'),
                onSaved: (value) => _title = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: const Text('Pick Date'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _pickTime,
                    child: const Text('Pick Time'),
                  ),
                ],
              ),
              if (_dateTime != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Selected Date & Time: ${_dateTime.toString()}',
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectLocation,
                child: const Text('Select Location'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Save Exam'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}