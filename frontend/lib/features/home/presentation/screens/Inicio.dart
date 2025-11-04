import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:frontend/features/home/domain/entities/event.dart'; // Entidad
import 'package:frontend/features/home/presentation/cubit/home_cubit.dart'; 
import 'package:frontend/features/home/presentation/cubit/home_state.dart'; 
import 'package:frontend/features/home/presentation/widgets/item_card.dart'; // <--- ¡Importación de ItemCard!
import 'package:frontend/shared/widgets/bottom_nav_bar.dart';
// Colores
const Color primaryColor = Color(0xFFFF9800);

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 1. Fondo
          Container(
            decoration: const BoxDecoration(
              // Asegúrate de tener esta imagen en assets/
              image: DecorationImage(
                image: AssetImage('assets/fondo.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.7)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          SafeArea(
            // BlocConsumer maneja la reconstrucción (builder) y los side-effects (listener)
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is HomeError) {
                  // Muestra un SnackBar si hay un error de carga
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                // ----------------------------------------------------
                // Manejo de Estados
                // ----------------------------------------------------
                if (state is HomeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  );
                }
                
                if (state is HomeError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${state.message}', style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => context.read<HomeCubit>().loadEvents(),
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  );
                }
                
                final loadedState = state as HomeLoaded;
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Barra Superior y Buscador (Estáticos)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                          ),
                          const Text('GROVE STREET', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withAlpha(230),
                          prefixIcon: const Icon(Icons.search, color: Colors.black54),
                          hintText: 'Buscar eventos...',
                          hintStyle: const TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Filtros de categorías (usa datos del Cubit)
                    SizedBox(
                      height: 45,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 20),
                        itemCount: loadedState.categories.length, 
                        itemBuilder: (context, index) {
                          final isSelected = loadedState.selectedCategoryIndex == index;
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ChoiceChip(
                              label: Text(
                                loadedState.categories[index], 
                                style: TextStyle(
                                  color: isSelected ? Colors.black : Colors.white,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              selected: isSelected,
                              selectedColor: primaryColor,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              onSelected: (value) {
                                // Llama al Cubit
                                context.read<HomeCubit>().selectCategory(index); 
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: isSelected ? BorderSide.none : const BorderSide(color: Colors.white30),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Lista de tarjetas (usa eventos filtrados del Cubit)
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 85), 
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: loadedState.filteredEvents.length, 
                        itemBuilder: (context, index) {
                          final event = loadedState.filteredEvents[index];
                          return ItemCard(event: event); 
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Barra inferior de navegación flotante
          const BottomNavBar(),
        ],
      ),
    );
  }
}