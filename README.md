# SmartSales Mobile

Aplicación móvil Flutter para el sistema de ventas SmartSales.

## Características

- 🔐 Autenticación JWT
- 📦 Gestión de productos y categorías
- 🛒 Carrito de compras
- 📊 Visualización de pedidos
- 👤 Gestión de perfil de usuario
- 🎨 UI moderna y responsive

## Configuración

### Backend URL

Edita el archivo `lib/core/config/api_config.dart` y configura la URL de tu backend:

```dart
static const String baseUrl = 'http://TU_IP:8000';
```

### Instalación

```bash
# Instalar dependencias
flutter pub get

# Ejecutar en modo debug
flutter run

# Compilar para producción
flutter build apk --release
```

## Estructura del Proyecto

```
lib/
├── core/           # Configuración, constantes, utilidades
├── models/         # Modelos de datos
├── providers/      # Gestión de estado (Provider)
├── services/       # Servicios API
├── screens/        # Pantallas de la aplicación
├── widgets/        # Widgets reutilizables
└── main.dart       # Punto de entrada
```

## Requisitos

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Backend SmartSales ejecutándose

## Credenciales de Prueba

Consulta con el administrador del sistema para obtener credenciales de acceso.
