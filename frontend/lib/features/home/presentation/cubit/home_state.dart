import 'package:frontend/features/home/domain/entities/event.dart'; 
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  final List<Event> allEvents; 
  final List<Event> filteredEvents; 
  final List<String> categories;
  final int selectedCategoryIndex;

  const HomeState({
    required this.allEvents,
    required this.filteredEvents,
    required this.categories,
    required this.selectedCategoryIndex,
  });

  @override
  List<Object?> get props => [allEvents, filteredEvents, categories, selectedCategoryIndex];
}

class HomeLoading extends HomeState {
  const HomeLoading() : super(
    allEvents: const [],
    filteredEvents: const [],
    // Definimos las categorías aquí
    categories: const ['All', 'Sports', 'Theaters', 'Music', 'Movies'], 
    selectedCategoryIndex: 0,
  );
}

class HomeLoaded extends HomeState {
  const HomeLoaded({
    required super.allEvents,
    required super.filteredEvents,
    required super.categories,
    required super.selectedCategoryIndex,
  });
  
  // Método copyWith para crear nuevos estados de forma inmutable
  HomeLoaded copyWith({
    List<Event>? allEvents,
    List<Event>? filteredEvents,
    List<String>? categories,
    int? selectedCategoryIndex,
  }) {
    return HomeLoaded(
      allEvents: allEvents ?? this.allEvents,
      filteredEvents: filteredEvents ?? this.filteredEvents,
      categories: categories ?? this.categories,
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  const HomeError({
    required this.message,
    required super.allEvents,
    required super.filteredEvents,
    required super.categories,
    required super.selectedCategoryIndex,
  });
  
  @override
  List<Object?> get props => [allEvents, filteredEvents, categories, selectedCategoryIndex, message];
}