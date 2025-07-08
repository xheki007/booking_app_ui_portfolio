class Item {
  final String id;
  final String title;
  final String location;
  final String imageUrl;
  final double price;

  Item({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.price,
  });
}

final List<Item> dummyItems = [
  Item(
    id: '1',
    title: 'Hotel Sunrise',
    location: 'Prishtina',
    imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    price: 49.99,
  ),
  Item(
  id: '2',
  title: 'Borea Sports Center',
  location: 'Peja',
  imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
  price: 35.00,
),
  Item(
    id: '3',
    title: 'Dental Appointment',
    location: 'Ferizaj',
    imageUrl: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
    price: 25.50,
  ),
];
