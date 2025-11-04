import 'package:equatable/equatable.dart';

// Entidad: Representación de los datos en la capa de negocio.
class Event extends Equatable {
  final int id;
  final String title;
  final String imageUrl;
  final String locationOrDate;
  final double rating;
  final bool isFavorite;

  const Event({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.locationOrDate,
    required this.rating,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [id, title, imageUrl, locationOrDate, rating, isFavorite];
}