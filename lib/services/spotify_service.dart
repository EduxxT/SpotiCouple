// lib/spotify_service.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

// Definimos los posibles estados de la conexión
enum SpotifyConnectionStatus {
  idle,       // Aún no se intenta conectar
  connecting, // Conectando...
  connected,  // ¡Conectado!
  error,      // Hubo un error
}

class SpotifyService with ChangeNotifier {
  // ¡IMPORTANTE! Reemplaza esto con tu Client ID
  static const String _clientId = "a8a853a2fd6e41409bbbe03eb20568e0";
  static const String _redirectUrl = "spoticouple://callback";

  // --- Variables de Estado ---
  // Hacemos privadas las variables y exponemos "getters" públicos
  // para que la UI no pueda modificarlas directamente.

  SpotifyConnectionStatus _status = SpotifyConnectionStatus.idle;
  String _accessToken = '';
  String _errorMessage = '';

  // --- Getters Públicos ---
  // La UI leerá estos valores para saber qué mostrar
  SpotifyConnectionStatus get status => _status;
  String get accessToken => _accessToken;
  String get errorMessage => _errorMessage;
  bool get isConnected => _status == SpotifyConnectionStatus.connected;

  // --- Lógica Principal ---

  Future<void> connect() async {
    // Si ya está conectado o conectando, no hagas nada
    if (_status == SpotifyConnectionStatus.connecting || 
        _status == SpotifyConnectionStatus.connected) return;

    try {
      // 1. Informa a los "oyentes" (la UI) que estamos conectando
      _status = SpotifyConnectionStatus.connecting;
      _errorMessage = ''; // Limpia errores previos
      notifyListeners(); // Esto actualiza la UI

      // 2. Intenta la conexión
      var token = await SpotifySdk.connectToSpotifyRemote(
        clientId: _clientId,
        redirectUrl: _redirectUrl,
      );

      // 3. ¡Éxito! Guarda el token e informa a la UI
      _accessToken = token as String;
      _status = SpotifyConnectionStatus.connected;
      notifyListeners();

    } on PlatformException catch (e) {
      // 4. Error de plataforma (ej. app no instalada)
      _status = SpotifyConnectionStatus.error;
      _errorMessage = 'Error: ${e.message}';
      notifyListeners();
    } catch (e) {
      // 5. Otro tipo de error
      _status = SpotifyConnectionStatus.error;
      _errorMessage = 'Error: ${e.toString()}';
      notifyListeners();
    }
  }

  // Podrías añadir más funciones aquí (disconnect, play, pause, etc.)
  // Por ejemplo:
  /*
  Future<void> disconnect() async {
    if (status != SpotifyConnectionStatus.connected) return;
    try {
      await SpotifySdk.disconnect();
      _status = SpotifyConnectionStatus.idle;
      _accessToken = '';
      notifyListeners();
    } catch (e) {
      _status = SpotifyConnectionStatus.error;
      _errorMessage = 'Error al desconectar: ${e.toString()}';
      notifyListeners();
    }
  }
  */
}