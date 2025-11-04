import 'package:flutter_bloc/flutter_bloc.dart';
// CORRECCIÓN: Usar package import para estabilidad
import 'package:frontend/features/home/domain/usecases/home_get_events_usecase.dart'; 
import 'home_state.dart';
// CORRECCIÓN: Necesitas importar Event para la lista filtrada
import 'package:frontend/features/home/domain/entities/event.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  // El Cubit solo tiene dependencia del UseCase
  final HomeGetEventsUseCase _getEventsUseCase;

  HomeCubit(this._getEventsUseCase) : super(const HomeLoading()) {
    loadEvents();
  }

  Future<void> loadEvents() async {
    emit(const HomeLoading());

    try {
      final events = await _getEventsUseCase.call();
      
      // Emitir el estado cargado, mostrando todos los eventos inicialmente
      final initialState = HomeLoaded(
        allEvents: events,
        filteredEvents: events, 
        categories: state.categories,
        selectedCategoryIndex: 0,
      );
      
      emit(initialState);
      
    } catch (e) {
      emit(HomeError(
        message: 'Fallo al cargar eventos: ${e.toString()}',
        allEvents: [],
        filteredEvents: [],
        categories: state.categories,
        selectedCategoryIndex: 0,
      ));
    }
  }

  void selectCategory(int index) {
    if (state is! HomeLoaded || state.selectedCategoryIndex == index) return;

    final currentState = state as HomeLoaded;
    final selectedCategory = currentState.categories[index];
    
    List<Event> newFilteredList;
    
    if (selectedCategory == 'All') {
      newFilteredList = List.from(currentState.allEvents);
    } else {
      // Simulación de filtro: Filtra eventos según el ID para el ejemplo
      newFilteredList = currentState.allEvents
        .where((e) => e.id % 3 == index)
        .toList();
    }
    
    // Emitir el nuevo estado con la lista filtrada y el índice de categoría
    emit(currentState.copyWith(
      filteredEvents: newFilteredList,
      selectedCategoryIndex: index,
    ));
  }
}