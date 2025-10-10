# 🏗️ Estructura del Proyecto Flutter – Grove Street

## 📂 Parte principal del proyecto

El proyecto sigue una **arquitectura modular y limpia (Clean Architecture)**, que permite mantener el código escalable, ordenado y fácil de mantener.  
La estructura base del proyecto se encuentra dentro de la carpeta principal `lib/`.

---

## 📁 Estructura general

```plaintext
lib/
│
├── features/               # MÓDULOS DE NEGOCIO (por Feature)
│   ├── auth/               # Autenticación, Login, Registro
│   │   ├── data/           # Implementación (Firebase/API)
│   │   ├── domain/         # Reglas de negocio puras (UserEntity)
│   │   └── presentation/   # UI + BLoC/Cubit de Autenticación
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
│   ├── theme/              # Definición de estilos y temas
│   ├── utils/              # Funciones auxiliares (loggers, formatters)
│   ├── errors/             # Manejo de errores y excepciones
│   └── injections/         # Inyección de dependencias (GetIt/Riverpod)
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
