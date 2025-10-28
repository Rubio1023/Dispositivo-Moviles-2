// lib/features/products/data/models/product_model.dart

// Importa la Entidad Pura para la conversión
// **Ajusta esta ruta** si tu archivo 'product.dart' no está en el path '../domain/entities/product.dart'
import '../../domain/entities/product.dart'; 

class ProductModel {
  // Propiedades del Modelo (Deben coincidir con tu JSON de la API)
  final int id;
  final String name;
  final double price;
  final int stock; 
  final String? description;
  final String? imageUrl; // Usamos String? si el campo puede ser nulo en la API

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    this.description,
    this.imageUrl,
  });

  // Constructor de Fábrica: Mapea JSON a Modelo
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      stock: json['stock'] as int, // Lectura del campo 'stock' del JSON
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }

  // Método de Conversión: Modelo (Data) a Entidad (Domain)
  // Aquí se pasa el valor de 'stock' al constructor de la Entidad Product.
  Product toEntity() {
    return Product(
      id: id,
      name: name,
      price: price,
      stock: stock, // Pasando el campo 'stock'
      description: description,
      imageUrl: imageUrl,
    );
  }
}