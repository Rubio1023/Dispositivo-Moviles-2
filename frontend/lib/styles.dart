import 'package:flutter/material.dart';

final TextStyle titleWhite = const TextStyle(
  color: Colors.white,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

final InputDecoration inputDecoration = InputDecoration(
  filled: true,
//  fillColor: const Color.fromARGB(26, 235, 229, 229),
  labelStyle: const TextStyle(color: Colors.white70),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
);

class AppStyles {
  static const background = BoxDecoration(
    // placeholder - we use Image.asset as background in screens
    color: Color.fromARGB(255, 255, 255, 255),
  );

  static const button = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFF2E64E5)),
    padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(vertical: 12, horizontal: 20)),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
  );
}
