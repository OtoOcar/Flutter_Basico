# 📦 Inventario Bodega Segunda - Flutter

Aplicación desarrollada en Flutter para la gestión básica de inventario de prendas en una bodega de segunda.

El proyecto fue realizado como actividad académica aplicando los conceptos fundamentales de Flutter: widgets, páginas, rutas y temas personalizados.

---

## 🚀 Características

- ✅ Pantalla de inicio de sesión
- ✅ Pantalla principal de inventario
- ✅ Conteo dinámico de códigos QR
- ✅ Selección de vueltas de inventario
- ✅ Confirmación de guardado
- ✅ Limpieza de conteo
- ✅ Cambio dinámico de tema (claro / oscuro)
- ✅ Navegación con GoRouter
- ✅ Enfoque automático en campo de lectura QR

---

## 🧱 Estructura del Proyecto
lib/
└── src/
├── app.dart
├── routes/
├── screens/
│ ├── login/
│ ├── inventory/
│ └── settings/
├── themes/
└── widgets/


La aplicación fue organizada de forma modular para facilitar mantenimiento y escalabilidad.

---

## 🖥 Pantallas

### 🔐 Login

- Logo superior
- Usuario
- Contraseña
- Mensaje informativo
- Botón ingresar

### 📋 Inventario

- Selección de vuelta
- Campo ubicación
- Campo lectura QR
- Contador en tarjeta (Card)
- Botones Guardar y Limpiar
- Menú desplegable
- Cerrar sesión

---

## 🎨 Temas

La aplicación incluye:

- 🌙 Tema Oscuro (por defecto)
- ☀️ Tema Claro

El cambio se realiza dinámicamente desde el menú "Temas".

---

## 🧠 Tecnologías Utilizadas

- Flutter
- Dart
- GoRouter

---

## 📦 Instalación

1. Clonar repositorio

[text](https://github.com/OtoOcar/Flutter_Basico.git)


2. Entrar al proyecto

cd nombre-del-proyecto


3. Instalar dependencias

flutter pub get


4. Ejecutar aplicación

flutter run



---

## 📌 Funcionalidad del Conteo QR

Cada vez que se ingresa un valor en el campo "Lectura QR" y se presiona ENTER:

- Se incrementa el contador.
- El campo se limpia.
- Se vuelve a enfocar automáticamente para la siguiente lectura.

---

## 📈 Mejoras Futuras

- Integración con lector QR real
- Base de datos local
- Autenticación real
- Internacionalización
- Manejo de estado avanzado (Provider / Riverpod)

---

## 👨‍💻 Autor

Óscar López  
Proyecto académico - 2026