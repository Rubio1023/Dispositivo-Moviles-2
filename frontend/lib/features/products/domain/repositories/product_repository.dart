// lib/features/products/domain/repositories/product_repository.dart

import 'package:dartz/dartz.dart';
import '../entities/product.dart'; // La entidad de negocio pura

abstract class ProductRepository {
  // El dominio solo pide la lista de entidades
  Future<Either<Failure, List<Product>>> getProducts(); 
}