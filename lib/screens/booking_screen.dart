import 'package:flutter/material.dart';
import '../models/item.dart';

class BookingScreen extends StatefulWidget {
  final Item item;
  const BookingScreen({required this.item, super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? selectedDate;
  String? selectedTime;
  int guestCount = 1;
  bool bookingConfirmed = false;

  final List<String> availableTimes = [
    "08:00",
    "10:00",
    "12:00",
    "14:00",
    "16:00",
    "18:00",
    "20:00"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.item.title}'),
        centerTitle: true,
      ),
      body: bookingConfirmed
          ? _buildConfirmation(context)
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Zgjedh datën",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.indigo.shade100),
                        color: Colors.indigo.shade50,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedDate != null
                                ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                : "Zgjedh një datë...",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Icon(Icons.calendar_today, color: Colors.indigo)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Time slot selection
                  Text("Zgjedh orarin", style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: availableTimes.map((time) {
                      final bool isSelected = selectedTime == time;
                      return ChoiceChip(
                        label: Text(time),
                        selected: isSelected,
                        selectedColor: Colors.indigo,
                        onSelected: (_) {
                          setState(() {
                            selectedTime = time;
                          });
                        },
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                        backgroundColor: Colors.indigo.shade50,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 22),

                  // Number of guests
                  Text("Numri i mysafirëve", style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: guestCount > 1
                            ? () => setState(() => guestCount--)
                            : null,
                      ),
                      Text(
                        '$guestCount',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => setState(() => guestCount++),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // Book Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                      label: const Text(
                        'Konfirmo Rezervimin',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onPressed: (selectedDate != null && selectedTime != null)
                          ? () {
                              setState(() {
                                bookingConfirmed = true;
                              });
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildConfirmation(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.celebration, color: Colors.indigo, size: 64),
          const SizedBox(height: 24),
          Text(
            "Rezervimi u konfirmua!",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "Data: ${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}\nOra: $selectedTime\nMysafirë: $guestCount",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Kthehu mbrapa', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
