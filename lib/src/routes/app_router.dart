import 'package:go_router/go_router.dart';
import '../screens/login/login_screen.dart';
import '../screens/inventory/inventory_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/settings/theme_screen.dart';
import '../screens/settings/language_screen.dart';
import '../screens/settings/profile_screen.dart';
import '../screens/about/about_screen.dart';

// Configuración de rutas de la aplicación
final GoRouter appRouter = GoRouter(
  initialLocation: '/',

  routes: [
    // Pantalla inicial (login)
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),

    /*
    // Pantalla principal de inventario
    GoRoute(
      path: '/inventory',
      builder: (context, state) => const InventoryScreen(),
    ),
    */

    // Pantalla principal de inventario capturando nombre de usuario (Es temporal)
    GoRoute(
      path: '/inventory',
      builder: (context, state) {
        // Se recibe el usuario enviado desde login
        final user = state.extra as String? ?? 'SIN_USUARIO';

        return InventoryScreen(usuario: user);
      },
    ),

    // Otras pantallas
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(path: '/theme', builder: (context, state) => const ThemeScreen()),
    GoRoute(
      path: '/language',
      builder: (context, state) => const LanguageScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(path: '/about', builder: (context, state) => const AboutScreen()),
  ],
);
