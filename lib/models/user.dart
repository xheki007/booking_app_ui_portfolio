class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
  });
}

// Dummy user (mund ta përdorësh kudo në UI ose te Booking)
final User demoUser = User(
  id: 'u1',
  name: 'Arber Jetishi',
  email: 'arber.jetishi@email.com',
  avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
);
