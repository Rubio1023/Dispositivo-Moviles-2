// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Requiere flutter_bloc
import 'features/auth/presentation/screens/welcome.dart';
import 'features/auth/presentation/screens/login.dart';
import 'features/auth/presentation/screens/sign_up.dart';
import 'features/home/presentation/screens/inicio.dart'; 
import 'features/cart/presentation/screens/cart.dart';
import 'features/profile/presentation/screens/profile.dart';
import 'shared/widgets/bottom_nav_bar.dart'; 

// ----------------------------------------------------
// Importaciones de Clean Architecture para DI (Home Feature)
// USANDO TUS NOMBRES DE ARCHIVO
// ----------------------------------------------------
import 'features/home/data/datasources/home_remote_datasource.dart'; 
import 'features/home/data/repositories/home_repositories_impl.dart'; 
import 'features/home/domain/usecases/home_get_events_usecase.dart'; 
import 'features/home/presentation/cubit/home_cubit.dart';

void main() {
  // 1. Configuración de la Inyección de Dependencias (DI) para 'home'
  
  // Capa Data
  final homeRemoteDataSource = HomeRemoteDataSourceImpl();
  final homeRepository = HomeRepositoryImpl(homeRemoteDataSource); // <--- Clase Implementada
  
  // Capa Domain
  final getEventsUseCase = HomeGetEventsUseCase(homeRepository); // <--- Tu UseCase
  
  runApp(MyApp(
    getEventsUseCase: getEventsUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final HomeGetEventsUseCase getEventsUseCase; // <--- Usando tu clase

  const MyApp({super.key, required this.getEventsUseCase});

  @override
  Widget build(BuildContext context) {
    // 2. Envolver la aplicación con MultiBlocProvider para proveer los Cubits
    return MultiBlocProvider(
      providers: [
        // Proveedor para la Feature 'Home'
        BlocProvider(
          create: (_) => HomeCubit(getEventsUseCase),
        ),

        // TODO: Añadir otros Cubits/BLoC aquí (ej: AuthCubit)
      ],
      child: MaterialApp(
        title: 'Grove Street',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.black,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF001F54)),
        ),
        // Rutas (¡QUITAMOS los 'const' que causaban error!)
        initialRoute: '/',
        routes: {
          '/': (context) => const Welcome(),
          // Se quita 'const' porque Inicio depende de BlocProvider
          '/inicio': (context) => Inicio(), 
          '/login': (context) => const Login(),
          '/sign_up': (context) => const SignUp(),
          '/cart': (context) => const Cart(),
          '/profile': (context) => const Profile(),
        },
      ),
    );
  }
}