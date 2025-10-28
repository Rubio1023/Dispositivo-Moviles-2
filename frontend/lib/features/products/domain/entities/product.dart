// lib/features/products/domain/entities/product.dart

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final double price;
  final int stock;
  final String? description; // <--- ¡Añadir este campo!
  final String? imageUrl;    // (Si también lo estás usando)

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    this.description, // <--- Definir como parámetro opcional (sin 'required')
    this.imageUrl,
  });

  @override
  // Asegúrate de añadir los nuevos campos a props si usas Equatable
  List<Object?> get props => [id, name, price, stock, description, imageUrl];
}