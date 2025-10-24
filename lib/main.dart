import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spoticouple/themes/theme_provider.dart';
// Importa tu HomePage
import 'pages/home_page.dart';
// ¡Importa el nuevo servicio!
import 'services/spotify_service.dart'; // Ajusta la ruta si lo creaste en otro lugar

void main() {
  runApp(
    // Usa MultiProvider para manejar varios providers
    MultiProvider(
      providers: [
        // Tu ThemeProvider existente
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        // ¡El nuevo SpotifyService Provider!
        ChangeNotifierProvider(create: (context) => SpotifyService()),
      ],
      child: const MyApp(), // Tu app principal
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Asegúrate de que HomePage exista en 'pages/home_page.dart'
      home: const HomePage(),
      // El tema sigue funcionando igual, lee el ThemeProvider
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

