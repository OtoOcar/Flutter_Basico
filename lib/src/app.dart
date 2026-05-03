import 'package:flutter/material.dart';
import 'routes/app_router.dart';
import 'themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Notificador global del tema actual
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.dark); // Inicia en modo oscuro

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode currentMode, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          theme: AppTheme.lightTheme,     // Tema claro
          darkTheme: AppTheme.darkTheme,  // Tema oscuro
          themeMode: currentMode,         // Tema activo
        );
      },
    );
  }
}