import 'package:flutter/material.dart';
import '../models/item.dart';

// Dummy bookings me foto që funksionojnë
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
      imageUrl: 'https://images.unsplash.com/photo-1465101178521-c1a9136a0b16?auto=format&fit=crop&w=600&q=80',
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
        centerTitle: true,
      ),
      body: dummyBookings.isEmpty
          ? const Center(child: Text("Nuk ka asnjë rezervim për të menaxhuar."))
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
                      // Foto e item-it dhe titulli
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                        child: Image.network(
                          booking.item.imageUrl,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 100,
                            color: Colors.grey[200],
                            child: const Center(child: Icon(Icons.broken_image, size: 40)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(booking.item.title, style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 4),
                            Text(
                              "Rezervim për: ${booking.guests} guests, më: ${booking.date.day}/${booking.date.month}/${booking.date.year} në ${booking.time}",
                              style: const TextStyle(color: Colors.black54, fontSize: 15),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _StatusChip(status: booking.status),
                                const Spacer(),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade700,
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(88, 36),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Kjo është vetëm UI demo!')),
                                    );
                                  },
                                  child: const Text("Approve"),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade600,
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(88, 36),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Kjo është vetëm UI demo!')),
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
