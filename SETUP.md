# Guía de Instalación - SmartSales Mobile

## Requisitos Previos

1. **Flutter SDK** instalado (versión 3.0 o superior)
   - Descarga desde: https://flutter.dev/docs/get-started/install
   - Verifica con: `flutter --version`

2. **Android Studio** o **VS Code** con extensiones de Flutter

3. **Backend SmartSales** ejecutándose
   - Debe estar corriendo en `http://34.38.132.155:8000`
   - O cambia la URL en `lib/core/config/api_config.dart`

## Pasos de Instalación

### 1. Clonar o verificar el proyecto

```bash
cd d:\Proyectos\ayuda\smartsales-mobile
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Verificar configuración de Flutter

```bash
     flutter doctor
```

Asegúrate de que no haya errores críticos.

### 4. Configurar la URL del Backend

Edita el archivo `lib/core/config/api_config.dart`:

```dart
static const String baseUrl = 'http://TU_IP_BACKEND:8000';
```

**Importante para Android Emulator:**
- Si usas emulador de Android, usa `http://10.0.2.2:8000` en lugar de `localhost`
- Si usas dispositivo físico, usa la IP de tu computadora en la red local

### 5. Ejecutar la aplicación

#### En modo debug:
```bash
flutter run
```

#### En un dispositivo específico:
```bash
# Ver dispositivos disponibles
flutter devices

# Ejecutar en un dispositivo específico
flutter run -d <device-id>
```

#### En Chrome (Web):
```bash
flutter run -d chrome
```

### 6. Compilar para producción

#### Android APK:
```bash
flutter build apk --release
```
El APK estará en: `build/app/outputs/flutter-apk/app-release.apk`

#### Android App Bundle (para Google Play):
```bash
flutter build appbundle --release
```

#### iOS (requiere Mac):
```bash
flutter build ios --release
```

## Solución de Problemas Comunes

### Error: "Gradle build failed"
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### Error: "Unable to connect to backend"
- Verifica que el backend esté ejecutándose
- Verifica la URL en `api_config.dart`
- Si usas emulador, asegúrate de usar `10.0.2.2` en lugar de `localhost`
- Verifica que `android:usesCleartextTraffic="true"` esté en AndroidManifest.xml

### Error: "Package not found"
```bash
flutter clean
flutter pub get
```

### Hot Reload no funciona
- Presiona `r` en la terminal para hot reload
- Presiona `R` para hot restart
- O usa el botón de hot reload en tu IDE

## Estructura del Proyecto

```
lib/
├── core/
│   ├── config/          # Configuración de API
│   ├── constants/       # Colores y constantes
│   └── utils/           # Validadores y utilidades
├── models/              # Modelos de datos
├── providers/           # Gestión de estado (Provider)
├── services/            # Servicios de API
├── screens/             # Pantallas de la app
├── widgets/             # Widgets reutilizables
└── main.dart            # Punto de entrada
```

## Funcionalidades Implementadas

✅ Autenticación (Login/Register)
✅ Gestión de productos
✅ Carrito de compras
✅ Búsqueda y filtrado de productos
✅ Categorías de productos
✅ Gestión de perfil
✅ Persistencia de sesión

## Próximos Pasos

- [ ] Implementar pantalla de checkout completa
- [ ] Agregar pantalla de pedidos
- [ ] Implementar notificaciones push
- [ ] Agregar modo offline
- [ ] Mejorar manejo de imágenes

## Credenciales de Prueba

Consulta con el administrador del sistema para obtener credenciales de prueba o crea una cuenta nueva desde la app.

## Soporte

Para problemas o preguntas, contacta al equipo de desarrollo.
