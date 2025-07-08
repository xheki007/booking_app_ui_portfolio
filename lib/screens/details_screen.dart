import 'package:flutter/material.dart';
import 'booking_screen.dart';

import '../models/item.dart';

class DetailsScreen extends StatelessWidget {
  final Item item;
  const DetailsScreen({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero Image with SliverAppBar
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: item.id,
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Subtle gradient overlay
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black54, Colors.transparent],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.indigo, size: 20),
                      const SizedBox(width: 4),
                      Text(item.location, style: const TextStyle(fontSize: 16, color: Colors.black54)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Description
                  Text(
                    "Ky është një përshkrim shembull për këtë vend. Shto tekst të shkurtër që tregon përfitimet, rehatinë dhe arsyet pse ky është zgjedhja e duhur për përdoruesin.",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 18),
                  // Facilities/Amenities
                  Text('Facilitete', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      FacilityChip(label: 'WiFi'),
                      SizedBox(width: 8),
                      FacilityChip(label: 'Parking'),
                      SizedBox(width: 8),
                      FacilityChip(label: '24/7 Support'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Price breakdown
                  Row(
                    children: [
                      Text(
                        '€${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.indigo),
                      ),
                      const SizedBox(width: 8),
                      const Text('/ night', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Map/location preview (image placeholder)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Book Now Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 3,
                      ),
                      icon: const Icon(Icons.calendar_month, color: Colors.white),
                      label: const Text(
                        'Book Now',
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => BookingScreen(item: item),
    ),
  );
},

                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Facility Chip Widget (mund ta vendosësh si file më vete në widgets)
class FacilityChip extends StatelessWidget {
  final String label;
  const FacilityChip({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.indigo.shade50,
      labelStyle: const TextStyle(color: Colors.indigo),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
