import 'package:flutter/material.dart';
import '../models/item.dart';

class MyBooking {
  final Item item;
  final String status; // p.sh. "Confirmed", "Pending", "Cancelled"
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

// Dummy data për rezervime
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
      imageUrl: 'https://images.unsplash.com/photo-1465101178521-c1a9136a0b16?auto=format&fit=crop&w=600&q=80',
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
        centerTitle: true,
      ),
      body: dummyBookings.isEmpty
          ? const Center(
              child: Text(
                "Nuk keni asnjë rezervim.",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dummyBookings.length,
              itemBuilder: (ctx, i) {
                final booking = dummyBookings[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Fotoja e item-it dhe titulli
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                        child: Image.network(
                          booking.item.imageUrl,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking.item.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 18, color: Colors.indigo.shade400),
                                const SizedBox(width: 4),
                                Text(
                                  booking.item.location,
                                  style: const TextStyle(color: Colors.black54, fontSize: 15),
                                ),
                                const Spacer(),
                                _StatusChip(status: booking.status),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: Colors.indigo.shade300),
                                const SizedBox(width: 4),
                                Text(
                                  "${booking.date.day}/${booking.date.month}/${booking.date.year}",
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(width: 16),
                                Icon(Icons.schedule, size: 16, color: Colors.indigo.shade300),
                                const SizedBox(width: 4),
                                Text(
                                  booking.time,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(width: 16),
                                Icon(Icons.group, size: 16, color: Colors.indigo.shade300),
                                const SizedBox(width: 4),
                                Text(
                                  "${booking.guests} guests",
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Butoni "Cancel" vetëm në UI
                            if (booking.status == "Confirmed" || booking.status == "Pending")
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                  icon: const Icon(Icons.cancel),
                                  label: const Text("Cancel"),
                                  onPressed: () {
                                    // Vetëm UI: s'bën asgjë, vetëm për demo
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Kjo është vetëm UI demo!')),
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

// StatusChip: ngjyrë sipas statusit
class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case "Confirmed":
        color = Colors.green;
        break;
      case "Pending":
        color = Colors.orange;
        break;
      case "Cancelled":
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    return Chip(
      label: Text(status),
      backgroundColor: color.withOpacity(0.12),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
