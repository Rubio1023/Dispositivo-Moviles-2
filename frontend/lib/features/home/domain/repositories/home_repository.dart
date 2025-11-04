import '../entities/event.dart';

// Abstracción (Contrato): Define lo que el UseCase necesita.
abstract class IHomeRepository {
  Future<List<Event>> getEvents();
}