import 'package:frontend/features/home/domain/entities/event.dart';
import 'package:frontend/features/home/domain/repositories/home_repository.dart';

// UseCase: Regla de negocio que coordina el flujo de datos.
class HomeGetEventsUseCase {
  final IHomeRepository repository;

  HomeGetEventsUseCase(this.repository);

  // El método 'call' permite usar la clase como una función: getEventsUseCase().
  Future<List<Event>> call() async {
    // Lógica de negocio si existiera (ej. revisar permisos, verificar caché).
    return repository.getEvents();
  }
}