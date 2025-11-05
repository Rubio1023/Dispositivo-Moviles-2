# 🏗️ Estructura del Proyecto Flutter – Grove Street

## 📂 Parte principal del proyecto

El proyecto sigue una **arquitectura modular y limpia (Clean Architecture) con feature-based**, que permite mantener el código escalable, ordenado y fácil de mantener.  
La estructura base del proyecto se encuentra dentro de la carpeta principal `lib/`.

---

## 📁 Estructura general

```plaintext
lib/
├── features/               # MÓDULOS DE NEGOCIO: Contiene toda la lógica por funcionalidad (Auth, Products, etc.)
│   ├── [nombre_feature]/   # (Ej: auth, products, cart)
│   │   ├── data/           # Implementación de la capa Data: Conecta la abstracción con las fuentes de datos reales.
│   │   │   ├── datasources/ # Fuentes de datos: Clases que hacen peticiones HTTP, BD local, etc.
│   │   │   └── repositories/ # Implementación del Contrato: Clase que implementa la interfaz de Domain.
│   │   ├── domain/         # LÓGICA DE NEGOCIO PURA: Reglas, modelos y contratos de la aplicación.
│   │   │   ├── entities/    # Modelos inmutables: Las Entidades de Negocio (ej. Event, User).
│   │   │   ├── repositories/ # Contratos (Interfaces): Define lo que el Repositorio DEBE hacer (IAuthRepository).
│   │   │   └── usecases/    # Reglas de Negocio: Coordina el flujo de datos para una tarea específica (ej. SignInUseCase).
│   │   └── presentation/   # UI Y GESTIÓN DE ESTADO: La capa de Flutter que el usuario ve.
│   │       ├── cubit/       # BLoC/Cubit y States: Lógica reactiva y definición de los estados de la UI.
│   │       └── screens/     # Pantallas Completas: Widgets que componen las vistas principales (ej. Login, Inicio).
│
├── core/                   # INFRAESTRUCTURA TÉCNICA: Lógica Transversal que no cambia entre features.
│   ├── constants/          # Valores Inmutables Globales: URLs base, API Keys, etc.
│   ├── errors/             # Errores de Dominio y Data: Definición de las clases `Failure` y `Exception` personalizadas.
│   ├── injections/         # Inyección de Dependencias (DI): Configuración e inicialización de GetIt/Riverpod.
│   └── network/            # Cliente HTTP/Network: Configuración del cliente Dio/HTTP (interceptores, *headers*).
│
├── shared/                 # COMPONENTES REUTILIZABLES: Reutilización de UI y código auxiliar.
│   ├── widgets/            # Widgets UI Comunes: Componentes que se usan en más de una feature (ej. `BottomNavBar`).
│   └── utils/              # Utilidades Auxiliares: Funciones que no son UI ni lógica de negocio (ej. *formatters*, *validators*).
│
├── config/                 # CONFIGURACIÓN DE LA APLICACIÓN: Valores y lógica de configuración general.
│   ├── routes/             # Navegación Centralizada: Sistema para definir y gestionar las rutas globales (GoRouter, etc.).
│   └── theme/              # Temas y Estilos: Definición de `ThemeData`, paleta de colores y tipografías.
│
├── main.dart               # Punto de Entrada: Inicializa la DI, llama a `runApp()`, y configura el widget raíz.
└── services/               # Servicios Externos: Servicios de terceros ligeros (ej. Firebase, notificaciones).

```
## Los Principios Fundamentales de la Arquitectura Limpia en Flutter
En esencia, la Arquitectura Limpia aboga por una clara separación entre la lógica de negocio y la interfaz de usuario. Esto se logra dividiendo la aplicación en tres capas principales:

**Capa de Dominio (Domain Layer):** Es el núcleo de tu aplicación. Contiene las reglas de negocio y las entidades de toda la empresa, encapsuladas en lo que se conoce como "casos de uso". Esta capa es completamente independiente de cualquier framework de UI o de fuentes de datos. Es Dart puro.

**Capa de Datos (Data Layer):** Esta capa es responsable de recuperar datos de diversas fuentes, como APIs remotas o bases de datos locales. Implementa las interfaces de los repositorios definidas en la capa de Dominio, actuando como un puente entre la lógica de negocio de tu aplicación y el mundo exterior de los datos.

**Capa de Presentación (Presentation Layer):** Es la capa más externa, responsable de todo lo que el usuario ve e interactúa. En Flutter, esta capa consiste en widgets y lógica de gestión de estado (por ejemplo, usando BLoC o Provider) para mostrar datos y capturar la entrada del usuario.

La regla clave en la Arquitectura Limpia es la Regla de Dependencia, que establece que las dependencias del código fuente solo pueden apuntar hacia adentro. Esto significa que la capa de Presentación puede depender de la capa de Dominio, y la capa de Datos también puede depender de la capa de Dominio, pero la capa de Dominio no puede depender de ninguna de las capas externas.

ahsdaskdhaskjd