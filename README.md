Parte principal de proyecto 

**Estructura principal**
carpeta principal
lib/
features/ # MÓDULOS DE NEGOCIO (Modularidad por Feature)
    auth/     # Autenticación, Login, Registro
        data/           # Implementación: Llama a Firebase/API para Auth
        domain/         # Reglas de negocio puras (ej. 'UserEntity')
        presentation/   # UI y BLoC/Cubit de Autenticación

    products/           # Catálogo, Búsqueda, Detalles
        data/
        domain/         # Reglas de negocio (ej. 'GetAllProductsUseCase')
        presentation/   # UI y BLoC/Cubit de Productos
    
    cart/               # Carrito de Compras
        data/
        domain/         # Lógica de carrito (ej. 'RemoveFromCartUseCase')
        presentation/

    checkout/           # Proceso de Pago, Envíos
        data/
        domain/         # Lógica de creación de pedidos (ej. 'CreateOrderUseCase')
        presentation/

    orders/             # Historial y Detalle de Pedidos
        data/
        domain/         # Reglas para pedidos pasados
        presentation/

    profile/            # Gestión de Perfil de Usuario
        data/
        domain/
        presentation/

Carpeta al nivel de raiz de lib
core/                   # INFRAESTRUCTURA TÉCNICA (Compartido)
    constants/          # Constantes globales (API Keys, URLs)
    theme/              # Definición de estilos de Flutter
    utils/              # Funciones de ayuda (formatters, logger)
    errors/             # Clases de errores (Failure, Exception)
    injections/         # Inyección de dependencias (Configuración de GetIt/Riverpod)

shared/                 # COMPONENTES DE UI Y AYUDAS DE PRESENTACIÓN
    widgets/            # Widgets de Flutter reutilizables (Button, CustomAppBar)
    helpers/            # Clases de ayuda a la UI (ej. 'ConnectivityHelper')

config/                 # CONFIGURACIÓN GENERAL
    routes/             # Configuración del sistema de enrutamiento
    env/                # Variables de entorno (Dev, Prod)

main.dart               # Punto de entrada de la aplicación
app.dart                # Widget principal (MaterialApp, ThemData)

Esta es la estrutura general que maneja el proyecto actualmente en base a la arquitectura  (Clean Architecture) 

**la estructura manejada dentro de las carpetas es la siguiente** 

lib/features/products/

data/
    datasources/        # Fuentes de datos (ej. product_remote_datasource.dart)
    models/             # Modelos de datos de la API (ej. product_model.dart - DTOs)
    repositories/       # Implementación del repositorio (ej. product_repository_impl.dart)

domain/
    entities/           # Entidades de negocio PURAS (ej. product.dart)
    repositories/       # Interfaces abstractas del repositorio (ej. product_repository.dart)
    usecases/           # Lógica de negocio (ej. get_all_products_usecase.dart)

presentation/
    cubit/              # Lógica de presentación y gestión de estado (ej. product_list_cubit.dart)
    pages/              # Pantallas completas (ej. product_list_page.dart)
    widgets/            # Componentes de UI específicos del módulo (ej. product_card_widget.dart)

esta es la estructura que se maneja de dentro de las carpetas corrspondientes el proyecto, este es un ejemplo de como esta organizada la estructura dentro de products o un modolu dentro de nuestro poryecto