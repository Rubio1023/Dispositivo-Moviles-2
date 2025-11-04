import 'package:frontend/features/home/domain/entities/event.dart'; 
import 'package:frontend/features/home/domain/repositories/home_repository.dart'; 
import 'package:frontend/features/home/data/datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements IHomeRepository {
  final IHomeRemoteDataSource remoteDataSource;

  // Se asegura de recibir la implementación del DataSource
  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Event>> getEvents() {
    // Aquí puedes añadir lógica de la capa Data:
    // 1. Manejo de errores de red (try-catch, lanzar excepciones Domain)
    // 2. Lógica de caché: si hay caché local, retornarla; sino, llamar al remote.
    
    // Por ahora, solo llama a la fuente de datos remota simulada:
    return remoteDataSource.fetchEvents();
  }
}