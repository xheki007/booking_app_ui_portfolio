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
    "08:00", "10:00", "12:00", "14:00", "16:00", "18:00", "20:00"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.item.title}', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: bookingConfirmed
          ? _buildConfirmation(context)
          : Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Choose a date",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              colorScheme: ColorScheme.dark(
                                primary: Colors.indigoAccent,
                                onPrimary: Colors.white,
                                surface: const Color(0xFF232526),
                                onSurface: Colors.white,
                              ),
                              dialogBackgroundColor: const Color(0xFF232526),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) setState(() => selectedDate = picked);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white10),
                        color: Colors.white.withOpacity(0.07),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedDate != null
                                ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                : "Select a date...",
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          const Icon(Icons.calendar_today, color: Colors.indigoAccent)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),

                  const Text("Choose a time",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: availableTimes.map((time) {
                      final bool isSelected = selectedTime == time;
                      return ChoiceChip(
                        label: Text(time),
                        selected: isSelected,
                        selectedColor: Colors.indigoAccent,
                        onSelected: (_) => setState(() => selectedTime = time),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.indigoAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        backgroundColor: Colors.white.withOpacity(0.09),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 22),

                  const Text("Number of guests",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: Colors.indigoAccent),
                        onPressed: guestCount > 1 ? () => setState(() => guestCount--) : null,
                      ),
                      Text('$guestCount', style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: Colors.indigoAccent),
                        onPressed: () => setState(() => guestCount++),
                      ),
                    ],
                  ),
                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                      label: const Text(
                        'Confirm Booking',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onPressed: (selectedDate != null && selectedTime != null)
                          ? () => setState(() => bookingConfirmed = true)
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
          const Icon(Icons.celebration, color: Colors.indigoAccent, size: 68),
          const SizedBox(height: 26),
          Text(
            "Booking Confirmed!",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            "Date: ${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}\n"
            "Time: $selectedTime\n"
            "Guests: $guestCount",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.white70),
          ),
          const SizedBox(height: 34),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigoAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: const Text('Back', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
