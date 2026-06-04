# 📦 Inventario Bodega Segunda - Flutter

Aplicación desarrollada en Flutter para la gestión básica de inventario de prendas en una bodega de segunda. Incluye registro fotográfico de novedades (prendas en mal estado) y personalización visual de la interfaz.

El proyecto fue realizado como actividad académica aplicando conceptos de Flutter: widgets, rutas, temas personalizados, manejo de estado con Provider y galería de imágenes con image_picker.

---

## 🚀 Características

- ✅ Pantalla de inicio de sesión
- ✅ Pantalla principal de inventario
- ✅ Conteo dinámico de códigos QR
- ✅ Selección de vueltas de inventario
- ✅ Confirmación de guardado y limpieza
- ✅ Cambio dinámico de tema (oscuro / claro / azul / rosa)
- ✅ Navegación con GoRouter
- ✅ Enfoque automático en campo de lectura QR
- ✅ Registro fotográfico de novedades (prendas dañadas)
- ✅ Galería de imágenes en cuadrícula
- ✅ Vista de imagen en tamaño completo con zoom
- ✅ Compartir imágenes con otras aplicaciones

---

## 🧱 Estructura del Proyecto

```
lib/
├── main.dart
└── src/
      ├── app.dart
      ├── controllers/
      │   ├── auth_controller.dart
      │   ├── inventory_controller.dart
      │   └── novedades_controller.dart
      ├── routes/
      │   └── app_router.dart
      ├── screens/
      │   ├── login/
      │   │     └── login_screen.dart
      │   ├── inventory/
      │   │     └── inventory_screen.dart
      │   ├── novedades/
      │   │     └── novedades_screen.dart
      │   └── settings/
      │       ├── settings_screen.dart
      │       ├── theme_screen.dart
      │       ├── language_screen.dart
      │       └── profile_screen.dart
      └── themes/
          └── app_theme.dart
```

La aplicación fue organizada de forma modular para facilitar mantenimiento y escalabilidad.

---

## 🖥 Pantallas

### 🔐 Login
- Logo superior
- Campo usuario
- Campo contraseña (obscureText)
- Validación de campos vacíos
- Botón ingresar

### 📋 Inventario
- Selección de vuelta (Vuelta 1, 2, 3, Reconteo)
- Campo ubicación
- Campo lectura QR con foco automático
- Contador en tarjeta (Card)
- Historial de lecturas
- Botones Guardar y Limpiar con confirmación
- Menú desplegable de navegación

### 📸 Novedades
- Registro fotográfico de prendas en mal estado
- Captura desde cámara o selección desde galería
- Descripción de la novedad
- Cuadrícula de fotos registradas
- Vista completa con zoom (InteractiveViewer)
- Compartir imagen con otras apps (WhatsApp, correo, etc.)
- Eliminar novedad con confirmación

---

## 🎨 Temas

La aplicación incluye cuatro temas visuales:

- 🌙 Tema Oscuro (por defecto)
- ☀️ Tema Claro
- 🔵 Tema Azul
- 🌸 Tema Rosa

El cambio se realiza dinámicamente desde el menú → Temas, sin reiniciar la aplicación.

---

## 🧠 Tecnologías Utilizadas

- Flutter / Dart
- GoRouter — navegación declarativa
- Provider — manejo de estado
- image_picker — acceso a cámara y galería
- share_plus — compartir imágenes
- path_provider — acceso al sistema de archivos

---

## 📦 Instalación

1. Clonar repositorio
```
git clone https://github.com/OtoOcar/Flutter_Basico.git
```

2. Entrar al proyecto
```
cd Flutter_Basico
```

3. Instalar dependencias
```
flutter pub get
```

4. Ejecutar aplicación
```
flutter run
```

---

## 📌 Funcionalidad del Conteo QR

Cada vez que se ingresa un valor en el campo "Lectura QR" y se presiona Enter:

- Se incrementa el contador.
- El código aparece en el historial de lecturas.
- El campo se limpia automáticamente.
- El foco regresa al campo para la siguiente lectura.

---

## 📸 Funcionalidad de Novedades

Cuando el operario encuentra una prenda en mal estado durante el inventario:

- Accede a Novedades desde el menú.
- Toma una foto o selecciona una imagen de la galería.
- Agrega una descripción (ej: "manga rota", "mancha de grasa").
- La foto queda registrada en la cuadrícula.
- Puede compartirla con el supervisor por WhatsApp u otras apps.

---

## 📈 Mejoras Futuras

- Persistencia local de novedades (SQLite o Hive)
- Sincronización con Firebase Storage
- Edición de imágenes (recortar, rotar, filtros)
- Exportación del inventario a CSV
- Autenticación real contra base de datos
- Internacionalización

---

## 👨‍💻 Autor

Óscar López  
Proyecto académico — 2026
