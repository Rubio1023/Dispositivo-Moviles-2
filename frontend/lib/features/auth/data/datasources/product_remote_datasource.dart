// lib/features/products/data/datasources/product_remote_datasource.dart

import '../../../../core/network/api_client.dart'; 
import '../models/product_model.dart'; // El modelo DTO de la API

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient client; 

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts() async {
    const path = '/products/';
    
    // Usamos el GET genérico. Devuelve la lista de JSON cruda.
    final List<dynamic> jsonList = await client.get(path); 
    
    // *PASO CLAVE:* Mapeo de la lista de JSON cruda a una lista de ProductModel
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }
}