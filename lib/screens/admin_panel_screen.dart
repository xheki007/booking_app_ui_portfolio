import 'package:flutter/material.dart';
import '../models/item.dart';

// MyBooking model (nëse nuk është në një file tjetër)
class MyBooking {
  final Item item;
  final String status;
  final DateTime date;
  final String time;
  final int guests;

  MyBooking({
    required this.item,
    required this.status,
    required this.date,
    required this.time,
    required this.guests,
  });
}

// Dummy bookings
final List<MyBooking> dummyBookings = [
  MyBooking(
    item: Item(
      id: '1',
      title: 'Hotel Sunrise',
      location: 'Prishtina',
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      price: 49.99,
    ),
    status: "Confirmed",
    date: DateTime.now().add(const Duration(days: 3)),
    time: "14:00",
    guests: 2,
  ),
  MyBooking(
    item: Item(
      id: '2',
      title: 'Borea Sports Center',
      location: 'Peja',
      imageUrl: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=600&q=80',
      price: 35.00,
    ),
    status: "Pending",
    date: DateTime.now().add(const Duration(days: 7)),
    time: "16:00",
    guests: 1,
  ),
  MyBooking(
    item: Item(
      id: '3',
      title: 'Dental Appointment',
      location: 'Ferizaj',
      imageUrl: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=600&q=80',
      price: 25.50,
    ),
    status: "Cancelled",
    date: DateTime.now().add(const Duration(days: 11)),
    time: "09:00",
    guests: 1,
  ),
];

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: dummyBookings.isEmpty
          ? const Center(
              child: Text(
                "No bookings to manage.",
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: dummyBookings.length,
              itemBuilder: (ctx, i) {
                final booking = dummyBookings[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 22),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.white10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.11),
                        blurRadius: 11,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                        child: Image.network(
                          booking.item.imageUrl,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking.item.title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              "For ${booking.guests} guests, on: ${booking.date.day}/${booking.date.month}/${booking.date.year} at ${booking.time}",
                              style: const TextStyle(color: Colors.white70, fontSize: 15),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _StatusChip(status: booking.status),
                                const Spacer(),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade700,
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(92, 36),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('This is a demo UI only!')),
                                    );
                                  },
                                  child: const Text("Approve"),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(92, 36),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('This is a demo UI only!')),
                                    );
                                  },
                                  child: const Text("Reject"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case "Confirmed":
        color = Colors.greenAccent.shade400;
        break;
      case "Pending":
        color = Colors.orangeAccent;
        break;
      case "Cancelled":
        color = Colors.redAccent;
        break;
      default:
        color = Colors.grey;
    }
    return Chip(
      label: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      backgroundColor: color.withOpacity(0.13),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
