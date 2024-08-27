// lib/Services/api_service.dart
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<void> updateVehicleLocation(LatLng vehiclePosition) async {
    final String apiUrl = 'http://66.135.11.124:4200/inicio';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'latitude': vehiclePosition.latitude.toString(),
        'longitude': vehiclePosition.longitude.toString(),
      },
    );

    if (response.statusCode != 200) {
      // Tratar erro de requisição
      throw Exception('Falha ao enviar localização');
    }
  }
}
