import 'package:flutter/foundation.dart';
import '../../../products/domain/entities/product.dart';

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, required this.quantity});
  double get subtotal => product.price * quantity;
}

class CartProvider with ChangeNotifier {
  final Map<int, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();

  void add(Product p, int qty) {
    if (_items.containsKey(p.id)) {
      _items[p.id]!.quantity += qty;
    } else {
      _items[p.id] = CartItem(product: p, quantity: qty);
    }
    notifyListeners();
  }

  void remove(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  double get total => _items.values.fold(0.0, (t, it) => t + it.subtotal);

  void updateQuantity(int productId, int qty) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity = qty;
      if (_items[productId]!.quantity <= 0) _items.remove(productId);
      notifyListeners();
    }
  }
}
