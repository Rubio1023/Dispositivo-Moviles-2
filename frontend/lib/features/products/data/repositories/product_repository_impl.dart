// lib/features/products/data/repositories/product_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart'; // Clases de error de dominio

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      // 1. Llama al Data Source (donde se hace la API call)
      final productModels = await remoteDataSource.getProducts();

      // 2. Convierte los Modelos (Data) a Entidades (Domain)
      final products = productModels.map((model) => model.toEntity()).toList();

      return Right(products); // Éxito
    } on ServerException catch (e) {
      // 3. Captura la excepción de la API y la traduce a un Failure de Dominio
      return Left(ServerFailure(message: e.message)); 
    }
  }
}