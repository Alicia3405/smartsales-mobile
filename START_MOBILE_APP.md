# 🚀 GUÍA DE INICIO - SMARTSALES MOBILE

## 📱 **CÓMO EJECUTAR LA APLICACIÓN MÓVIL**

### **📋 Requisitos Previos:**
```bash
✅ Flutter SDK 3.0.0+ instalado
✅ Android Studio con emulador configurado
✅ Backend SmartSales ejecutándose en localhost:8000
✅ Dispositivo Android (emulador o físico)
```

---

## 🔧 **CONFIGURACIÓN INICIAL:**

### **1. Verificar Flutter:**
```bash
flutter doctor
```
**Debe mostrar:** ✅ Flutter, ✅ Android toolchain, ✅ Android Studio

### **2. Configurar Backend:**
```bash
# En terminal 1 - Iniciar backend
cd smartsales-backend
python manage.py runserver

# Verificar que esté funcionando en:
# http://localhost:8000
```

### **3. Configurar Emulador:**
```bash
# Listar emuladores disponibles
flutter emulators

# Iniciar emulador (reemplaza con tu emulador)
flutter emulators --launch <emulator_id>
```

---

## 📱 **EJECUTAR LA APLICACIÓN:**

### **🚀 Comando Principal:**
```bash
# Navegar al directorio móvil
cd smartsales-mobile

# Instalar dependencias
flutter pub get

# Ejecutar la aplicación
flutter run
```

### **⚡ Comandos Útiles:**
```bash
# Ejecutar en modo debug
flutter run --debug

# Ejecutar en modo release
flutter run --release

# Hot reload (durante desarrollo)
# Presiona 'r' en la terminal

# Hot restart (durante desarrollo)  
# Presiona 'R' en la terminal

# Detener la aplicación
# Presiona 'q' en la terminal
```

---

## 🔗 **CONFIGURACIÓN DE CONEXIÓN:**

### **📡 Para Emulador Android:**
La configuración actual está optimizada para emulador:
```dart
// lib/core/config/api_config.dart
static const String baseUrl = 'http://10.0.2.2:8000';
```

### **📱 Para Dispositivo Físico:**
Si usas un dispositivo físico, cambia la URL:
```dart
// Reemplaza con la IP de tu computadora
static const String baseUrl = 'http://192.168.1.XXX:8000';

// Para encontrar tu IP:
// Windows: ipconfig
// Mac/Linux: ifconfig
```

---

## 👤 **USUARIOS DE PRUEBA:**

### **🔐 Credenciales Disponibles:**
```
📧 Email: test_cliente@example.com
🔑 Contraseña: password123
👤 Rol: Cliente

📧 Email: admin@example.com  
🔑 Contraseña: admin123
👤 Rol: Administrador (solo para web)
```

### **✨ O Crear Nueva Cuenta:**
```
1. Abrir la app
2. Tap en "Regístrate"
3. Llenar el formulario
4. ¡Listo para usar!
```

---

## 📱 **FUNCIONALIDADES DISPONIBLES:**

### **🛍️ Como Cliente Puedes:**
```
✅ Navegar el catálogo de productos
✅ Buscar productos por nombre
✅ Filtrar por categorías  
✅ Agregar productos al carrito
✅ Gestionar cantidades en el carrito
✅ Ver el historial de pedidos
✅ Gestionar tu perfil
✅ Cerrar sesión
```

### **🎯 Flujo Principal:**
```
1. 📱 Abrir app → Splash Screen
2. 🔐 Login/Register → Autenticación
3. 🏠 Home → Catálogo de productos
4. 🛒 Agregar al carrito → Productos seleccionados
5. 💳 Ver carrito → Revisar compra
6. 📦 Ver pedidos → Historial
```

---

## 🛠️ **DESARROLLO Y DEBUGGING:**

### **🔍 Herramientas de Debug:**
```bash
# Abrir DevTools de Flutter
flutter pub global activate devtools
flutter pub global run devtools

# Inspeccionar widgets
# En el emulador: Ctrl+Shift+I (Windows)

# Ver logs en tiempo real
flutter logs
```

### **📊 Análisis de Código:**
```bash
# Verificar problemas de código
flutter analyze

# Formatear código
flutter format .

# Ejecutar tests (cuando estén disponibles)
flutter test
```

---

## 🔧 **SOLUCIÓN DE PROBLEMAS:**

### **❌ Error: "No connected devices"**
```bash
# Verificar dispositivos conectados
flutter devices

# Si no aparece el emulador:
flutter emulators --launch <emulator_name>

# Si no aparece dispositivo físico:
# 1. Habilitar "Depuración USB" en el dispositivo
# 2. Conectar por USB
# 3. Aceptar permisos de depuración
```

### **❌ Error: "Connection refused"**
```bash
# Verificar que el backend esté funcionando:
curl http://localhost:8000/api/v1/productos/

# Si usas dispositivo físico, verificar IP:
# Cambiar 10.0.2.2 por la IP real de tu computadora
```

### **❌ Error: "Gradle build failed"**
```bash
# Limpiar y reconstruir
flutter clean
flutter pub get
flutter run
```

### **❌ Error: "Hot reload not working"**
```bash
# Hacer hot restart completo
# Presiona 'R' en la terminal de flutter run
```

---

## 📂 **ESTRUCTURA DE ARCHIVOS IMPORTANTES:**

### **🔧 Configuración:**
```
lib/core/config/api_config.dart     # URLs del backend
lib/core/constants/app_colors.dart  # Colores del tema
```

### **📱 Pantallas Principales:**
```
lib/screens/login_screen.dart       # Pantalla de login
lib/screens/home_screen.dart        # Catálogo de productos  
lib/screens/cart_screen.dart        # Carrito de compras
lib/screens/orders_screen.dart      # Historial de pedidos
```

### **🔄 Estado Global:**
```
lib/providers/auth_provider.dart    # Autenticación
lib/providers/product_provider.dart # Productos y categorías
lib/providers/cart_provider.dart    # Carrito de compras
```

---

## 🎯 **PRÓXIMOS PASOS:**

### **🚀 Para Desarrollo:**
```
1. Ejecutar flutter run
2. Hacer cambios en el código
3. Usar hot reload (r) para ver cambios
4. Usar hot restart (R) si es necesario
5. Probar en diferentes dispositivos
```

### **📱 Para Producción:**
```
1. flutter build apk --release
2. Instalar APK en dispositivos
3. Configurar URLs de producción
4. Publicar en Google Play Store
```

---

## 🎉 **¡LISTO PARA USAR!**

### **🚀 Comando Rápido de Inicio:**
```bash
# Terminal 1: Backend
cd smartsales-backend && python manage.py runserver

# Terminal 2: Mobile App  
cd smartsales-mobile && flutter run
```

### **📱 Resultado Esperado:**
```
✅ App se abre en el emulador/dispositivo
✅ Splash screen aparece brevemente
✅ Pantalla de login se muestra
✅ Puedes registrarte o iniciar sesión
✅ Catálogo de productos se carga
✅ Carrito funciona correctamente
✅ Historial de pedidos está disponible
```

**¡La aplicación móvil SmartSales está lista para usar!** 🎉📱

**Disfruta explorando todas las funcionalidades implementadas para clientes.** 🛍️✨
