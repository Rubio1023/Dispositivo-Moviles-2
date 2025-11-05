import 'package:flutter/foundation.dart';
import '../models/product.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';


class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  double get subtotal => product.price * quantity;
}

class CartProvider with ChangeNotifier {
  final Map<int, CartItem> _items = {};

  // Devuelve lista de items 
  List<CartItem> get items => _items.values.toList();

  // Agregar un producto al carrito
  void add(Product p, int qty, {String? size}) {
    if (_items.containsKey(p.id)) {
      _items[p.id]!.quantity += qty;
    } else {
      _items[p.id] = CartItem(product: p, quantity: qty);
    }
    notifyListeners();
  }


  // Eliminar producto por ID
  void remove(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // Vaciar el carrito
  void clear() {
    _items.clear();
    notifyListeners();
  }

  // Total del carrito
  double get total =>
      _items.values.fold(0.0, (sum, item) => sum + item.subtotal);

  // Actualizar cantidad
  void updateQuantity(int productId, int qty) {
    if (_items.containsKey(productId)) {
      if (qty > 0) {
        _items[productId]!.quantity = qty;
      } else {
        _items.remove(productId);
      }
      notifyListeners();
    }
  }
  // Cantidad total de productos
  int get itemCount =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);


 /* // Actualiza stock   
  Future<void> processPayment(int productId) async {
    try {
      final url = Uri.parse('http://192.168.1.9/api/checkout/');
      //127.0.0.1

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'product_id': productId}),
      );

      if (response.statusCode == 200) {
        clear();
        notifyListeners();
        debugPrint("Pago procesado correctamente.");
      } else {
        debugPrint("Error al procesar pago: ${response.body}");
        throw Exception('Error al procesar el pago');
      }
    } catch (e) {
      debugPrint("Error de conexión: $e");
      rethrow;
    }
  }*/
}