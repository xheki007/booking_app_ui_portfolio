import 'package:flutter/material.dart';
import '../models/item.dart';

// Modeli MyBooking (nëse nuk është tashmë në një file të përbashkët)
class MyBooking {
  final Item item;
  final String status; // "Confirmed", "Pending", "Cancelled"
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
];

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: dummyBookings.isEmpty
          ? const Center(
              child: Text(
                "No bookings yet.",
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: dummyBookings.length,
              itemBuilder: (ctx, i) {
                final booking = dummyBookings[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.13),
                        blurRadius: 12,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        child: Image.network(
                          booking.item.imageUrl,
                          height: 110,
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
                                  color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 18, color: Colors.indigoAccent),
                                const SizedBox(width: 4),
                                Text(
                                  booking.item.location,
                                  style: const TextStyle(color: Colors.white70, fontSize: 15),
                                ),
                                const Spacer(),
                                _StatusChip(status: booking.status),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: Colors.indigoAccent),
                                const SizedBox(width: 4),
                                Text(
                                  "${booking.date.day}/${booking.date.month}/${booking.date.year}",
                                  style: const TextStyle(fontSize: 15, color: Colors.white),
                                ),
                                const SizedBox(width: 16),
                                Icon(Icons.schedule, size: 16, color: Colors.indigoAccent),
                                const SizedBox(width: 4),
                                Text(
                                  booking.time,
                                  style: const TextStyle(fontSize: 15, color: Colors.white),
                                ),
                                const SizedBox(width: 16),
                                Icon(Icons.group, size: 16, color: Colors.indigoAccent),
                                const SizedBox(width: 4),
                                Text(
                                  "${booking.guests} guests",
                                  style: const TextStyle(fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (booking.status == "Confirmed" || booking.status == "Pending")
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.redAccent,
                                  ),
                                  icon: const Icon(Icons.cancel),
                                  label: const Text("Cancel"),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('This is a demo UI only!')),
                                    );
                                  },
                                ),
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

// StatusChip dark, elegant
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
