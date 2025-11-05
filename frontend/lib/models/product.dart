class Product {
  final int id;
  final String name;
  final double price;
  int stock;
  final String? imageUrl;

  Product({required this.id, required this.name, required this.price, required this.stock, this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      name: json['name'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      stock: json['stock'] is int ? json['stock'] : int.tryParse(json['stock'].toString()) ?? 0,
      imageUrl: json['image_url'] as String?,
    );
  }
}
