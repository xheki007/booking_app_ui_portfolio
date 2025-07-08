import 'package:flutter/material.dart';

class CalendarPicker extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarPicker({required this.selectedDate, required this.onDateSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.calendar_today, color: Colors.white),
      label: Text(
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
        style: const TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigoAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
