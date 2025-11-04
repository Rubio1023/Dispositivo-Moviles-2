import 'package:flutter/material.dart';
import '../../domain/entities/event.dart';

// Colores (se recomienda centralizarlos en styles.dart o config/)
const Color primaryColor = Color(0xFFFF9800);

class ItemCard extends StatelessWidget {
  final Event event;

  const ItemCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del evento
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                event.imageUrl, 
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                  Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 50, color: Colors.black38),
                    ),
                  ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title, 
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  event.locationOrDate, 
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: primaryColor),
                        const SizedBox(width: 4),
                        Text(event.rating.toString()), 
                      ],
                    ),
                    Icon(
                      event.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: event.isFavorite ? primaryColor : Colors.black54,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}