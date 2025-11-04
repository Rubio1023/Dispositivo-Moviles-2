# 🏗️ Estructura del Proyecto Flutter – Grove Street

## 📂 Parte principal del proyecto

El proyecto sigue una **arquitectura modular y limpia (Clean Architecture) con feature-based**, que permite mantener el código escalable, ordenado y fácil de mantener.  
La estructura base del proyecto se encuentra dentro de la carpeta principal `lib/`.

---

## 📁 Estructura general

```plaintext
lib/
│
├── features/               # MÓDULOS DE NEGOCIO (por Feature)
│   ├── auth/               # Autenticación, Login, Registro
│   │   ├── data/           # Implementación (Supabase/API)
|   |   |     ├── datasources/
|   |   |     ├── archivo.dart
|   |   |     ├── repositories/
|   |   |     ├── archivo.dart
│   │   ├── domain/         # Reglas de negocio puras (UserEntity)
|   |   |     ├── entities/
|   |   |     ├── archivo.dart
|   |   |     ├── repositories/
|   |   |     ├── archivo.dart
|   |   |     ├── usecases/
|   |   |     ├── archivo.dart
│   │   ├── presentation/   # UI + BLoC/Cubit de Autenticación
|   |   |     ├── cubit/
|   |   |     ├── archivo.dart
|   |   |     ├── screens/
|   |   |     ├── archivo.dart
|   |   |     ├── widgets/
|   |   |     ├── archivo.dar
│   │
│   ├── products/           # Catálogo, Búsqueda, Detalles
│   │   ├── data/
│   │   ├── domain/         # Lógica de productos (GetAllProductsUseCase)
│   │   └── presentation/
│   │
│   ├── cart/               # Carrito de Compras
│   │   ├── data/
│   │   ├── domain/         # Lógica de carrito (RemoveFromCartUseCase)
│   │   └── presentation/
│   │
│   ├── checkout/           # Proceso de Pago y Envíos
│   │   ├── data/
│   │   ├── domain/         # Creación de pedidos (CreateOrderUseCase)
│   │   └── presentation/
│   │
│   ├── orders/             # Historial y Detalle de Pedidos
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── profile/            # Gestión de Perfil de Usuario
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── core/                   # INFRAESTRUCTURA TÉCNICA (compartido)
│   ├── constants/          # Constantes globales (API Keys, URLs)
│   ├── errors/              # Definición de estilos y temas
│   ├── injections/              # Funciones auxiliares (loggers, formatters)
│   ├── netword/             # Manejo de errores y excepciones
│   ├── theme/         # Inyección de dependencias (GetIt/Riverpod)
│   └── utils/         
│
├── shared/                 # COMPONENTES REUTILIZABLES DE UI
│   ├── widgets/            # Widgets globales (Botones, AppBars)
│   └── helpers/            # Clases auxiliares (ConnectivityHelper)
│
├── config/                 # CONFIGURACIÓN GENERAL
│   ├── routes/             # Sistema de rutas (GoRouter, AutoRoute)
│   └── env/                # Variables de entorno (Dev, Prod)
│
├── main.dart               # Punto de entrada de la aplicación
└── app.dart                # Widget raíz (MaterialApp, ThemeData)
```
## Los Principios Fundamentales de la Arquitectura Limpia en Flutter
En esencia, la Arquitectura Limpia aboga por una clara separación entre la lógica de negocio y la interfaz de usuario. Esto se logra dividiendo la aplicación en tres capas principales:

**Capa de Dominio (Domain Layer):** Es el núcleo de tu aplicación. Contiene las reglas de negocio y las entidades de toda la empresa, encapsuladas en lo que se conoce como "casos de uso". Esta capa es completamente independiente de cualquier framework de UI o de fuentes de datos. Es Dart puro.

**Capa de Datos (Data Layer):** Esta capa es responsable de recuperar datos de diversas fuentes, como APIs remotas o bases de datos locales. Implementa las interfaces de los repositorios definidas en la capa de Dominio, actuando como un puente entre la lógica de negocio de tu aplicación y el mundo exterior de los datos.

**Capa de Presentación (Presentation Layer):** Es la capa más externa, responsable de todo lo que el usuario ve e interactúa. En Flutter, esta capa consiste en widgets y lógica de gestión de estado (por ejemplo, usando BLoC o Provider) para mostrar datos y capturar la entrada del usuario.

La regla clave en la Arquitectura Limpia es la Regla de Dependencia, que establece que las dependencias del código fuente solo pueden apuntar hacia adentro. Esto significa que la capa de Presentación puede depender de la capa de Dominio, y la capa de Datos también puede depender de la capa de Dominio, pero la capa de Dominio no puede depender de ninguna de las capas externas.