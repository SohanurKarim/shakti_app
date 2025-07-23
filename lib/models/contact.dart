class Contact {
  String name;
  String email;
  String phone;
  String post;
  String location;
  String description;
  bool isFavorite; // Add this line

  Contact({
    required this.name,
    required this.email,
    required this.phone,
    required this.post,
    required this.location,
    required this.description,
    this.isFavorite = false, // Default to false
  });
}
