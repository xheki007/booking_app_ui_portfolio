import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/item_card.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Listings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
              ),
            ),
          ),
          // Category chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                Chip(label: Text('All')),
                SizedBox(width: 8),
                Chip(label: Text('Hotels')),
                SizedBox(width: 8),
                Chip(label: Text('Sports')),
                SizedBox(width: 8),
                Chip(label: Text('Appointments')),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // List of item cards
          Expanded(
            child: ListView.builder(
              itemCount: dummyItems.length,
              itemBuilder: (ctx, i) => ItemCard(
                item: dummyItems[i],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsScreen(item: dummyItems[i]),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
