import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // <-- Import provider
import 'package:spoticouple/components/drawer_component.dart';
// Asegúrate que la ruta al servicio sea correcta (ajusta si es necesario)
import '../services/spotify_service.dart'; // <-- Import SpotifyService

// Cambia de StatefulWidget a StatelessWidget porque Provider manejará el estado
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtén la instancia del SpotifyService usando Provider
    final spotifyService = context.watch<SpotifyService>(); // <-- Añade esta línea

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text('S P O T I C O U P L E')),
      drawer: const MyDrawer(),
      // Añade el body para mostrar el botón y el estado
      body: Center( // Centra el contenido
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
            children: <Widget>[
              // Botón para conectar con Spotify
              ElevatedButton(
                // Deshabilita si está conectando o ya conectado
                onPressed: (spotifyService.status == SpotifyConnectionStatus.connecting ||
                           spotifyService.status == SpotifyConnectionStatus.connected)
                    ? null
                    : spotifyService.connect, // Llama al método del servicio
                child: Text('Conectar con Spotify'),
              ),
              SizedBox(height: 30), // Espaciador

              // Muestra el widget que representa el estado actual
              _buildStatusWidget(spotifyService), // <-- Llama a la función helper
            ],
          ),
        ),
      ),
    );
  }

  // --- NUEVO: Función helper para construir el widget de estado ---
  Widget _buildStatusWidget(SpotifyService service) {
    switch (service.status) {
      case SpotifyConnectionStatus.idle:
        return Text('Aún no conectado');
      case SpotifyConnectionStatus.connecting:
        return Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Conectando...'),
          ],
        );
      case SpotifyConnectionStatus.connected:
        return Column(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 40),
            SizedBox(height: 10),
            Text('¡Conectado exitosamente!', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Access Token:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            SelectableText( // Para poder copiar el token
              service.accessToken,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ],
        );
      case SpotifyConnectionStatus.error:
        return Column(
          children: [
            Icon(Icons.error, color: Colors.red, size: 40),
            SizedBox(height: 10),
            Text('Error al conectar:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(
              service.errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          ],
        );
    }
  }
} // <-- Fin de la clase HomePage