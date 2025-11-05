import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../services/api_service.dart';
import '../utils/session_manager.dart';
import 'Login.dart';

class ProductDetail extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int quantity = 0;
  String selectedSize = 'M'; // Talla por defecto

  @override
  Widget build(BuildContext context) {
    final productData = widget.product;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "GROVE STREET",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/cart'),
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen principal
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/model.jpeg',
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Miniaturas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      'assets/model.jpeg',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Nombre del producto
            Text(
              productData['name'] ?? 'Producto sin nombre',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),
            const Text(
              'El modelo utiliza una talla M y mide 1.80 cm.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 20),

          // Precio
            Text(
              "\$ ${productData['price'].toString()} COP",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),

            // Sección de tallas
            const Text(
              'Tallas:',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            const SizedBox(height: 6),
            Row(
              children: ['XS', 'S', 'M', 'L', 'XL']
                  .map(
                    (size) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: ChoiceChip(
                        label: Text(size),
                        selected: selectedSize == size,
                        onSelected: (_) {
                          setState(() => selectedSize = size);
                        },
                        selectedColor: Colors.black,
                        labelStyle: TextStyle(
                          color:
                              selectedSize == size ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),

            // Botones cantidad
            
            

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: quantity > 0
                      ? () {
                          setState(() {
                            quantity--;
                          });
                        }
                      : null,
                ),
                Text(
                  quantity.toString(),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: (quantity < (widget.product['stock'] ?? 0))
                      ? () {
                          setState(() {
                            quantity++;
                          });
                        }
                      : null,
                ),
              ],
            ),







            const SizedBox(height: 10),

            // Botón Añadir al carrito
           SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
               onPressed: () async {
  final user = await SessionManager.getUser();

  if (user == null) {
    // Usuario no autenticado
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Login()),
      );
    }
    return;
  }

  // Aquí solo llega si el usuario SÍ está autenticado
  try {
    final p = Product(
      id: productData['id'],
      name: productData['name'],
      price: double.tryParse(productData['price'].toString()) ?? 0.0,
      stock: productData['stock'] ?? '',
      imageUrl: productData['image'] ?? '',
    );

    cartProvider.add(p, quantity);

    await ApiService.addToCart(
      user['id'],
      p.id,
      quantity,
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${p.name} añadido al carrito (Talla: $selectedSize)'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al añadir al carrito: $e')),
    );
  }
},

                
                child: const Text(
                  "AÑADIR AL CARRITO",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Descripción del producto
            Text(
              productData['description'] ??
                  'Camiseta de color negro de horma Boxy, elaborada en tela 100% algodón de alto gramaje (200 gr), desarrollada con estampado gráfico en DTF de alta calidad.',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
