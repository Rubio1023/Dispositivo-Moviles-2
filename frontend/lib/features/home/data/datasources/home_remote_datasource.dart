import 'package:frontend/features/home/domain/entities/event.dart'; // CORREGIDA a package import

abstract class IHomeRemoteDataSource {
  Future<List<Event>> fetchEvents();
}

// Simula la llamada a la API y mapea los datos a la Entidad Event.
class HomeRemoteDataSourceImpl implements IHomeRemoteDataSource {
  @override
  Future<List<Event>> fetchEvents() async {
    // Simular un retardo de red para ver el estado Loading
    await Future.delayed(const Duration(seconds: 1));

    // Datos simulados (como si vinieran de un JSON)
    return List.generate(15, (index) => Event(
      id: index,
      title: 'Concierto de Rock ID ${index + 1}',
      imageUrl: 'https://picsum.photos/id/${200 + index}/300/200',
      locationOrDate: index.isEven ? 'Today, 8 PM' : 'Stadium A, Main Hall',
      rating: 4.0 + (index % 5) * 0.1,
      isFavorite: index.isEven,
    ));
  }
}