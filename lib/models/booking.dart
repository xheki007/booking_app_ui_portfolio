import 'item.dart';
import 'user.dart';

class Booking {
  final String id;
  final Item item;
  final User user;
  final String status; // "Confirmed", "Pending", "Cancelled"
  final DateTime date;
  final String time;
  final int guests;

  Booking({
    required this.id,
    required this.item,
    required this.user,
    required this.status,
    required this.date,
    required this.time,
    required this.guests,
  });
}

// Dummy bookings – përdoreni në çdo UI që kërkon një listë rezervimesh
final List<Booking> dummyBookings = [
  Booking(
    id: 'b1',
    item: Item(
      id: '1',
      title: 'Hotel Sunrise',
      location: 'Prishtina',
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      price: 49.99,
    ),
    user: demoUser,
    status: "Confirmed",
    date: DateTime.now().add(const Duration(days: 3)),
    time: "14:00",
    guests: 2,
  ),
  Booking(
    id: 'b2',
    item: Item(
      id: '2',
      title: 'Borea Sports Center',
      location: 'Peja',
      imageUrl: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=600&q=80',
      price: 35.00,
    ),
    user: demoUser,
    status: "Pending",
    date: DateTime.now().add(const Duration(days: 7)),
    time: "16:00",
    guests: 1,
  ),
];
