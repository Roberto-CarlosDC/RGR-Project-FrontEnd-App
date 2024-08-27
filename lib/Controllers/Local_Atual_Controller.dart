import 'dart:async'; // Para usar Timer
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../Models/Trip_Model.dart';
import '../Services/APIService.dart'; // Importar o serviço da API

class TripController {
  final TripModel tripModel;
  GoogleMapController? mapController;
  Location _location = Location();
  Timer? _timer;

  TripController({required this.tripModel});

  void init() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Solicitar permissão de localização
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Iniciar o timer para enviar a localização a cada 5 segundos
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
      LocationData currentLocation = await _location.getLocation();
      if (tripModel.isTripActive && tripModel.isUserConfirmed) {
        LatLng vehiclePosition =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
        updateVehicleLocation(vehiclePosition);

        // Enviar localização para a API
        await ApiService.updateVehicleLocation(vehiclePosition);
      }
    });
  }

  void updateVehicleLocation(LatLng vehiclePosition) {
    tripModel.vehiclePosition = vehiclePosition;
    mapController?.animateCamera(
      CameraUpdate.newLatLng(vehiclePosition),
    );
  }

  Set<Marker> getVehicleMarker() {
    if (tripModel.vehiclePosition != null) {
      return {
        Marker(
          markerId: MarkerId('vehicle_marker'),
          position: tripModel.vehiclePosition!,
          infoWindow: InfoWindow(title: "Veículo Atual"),
        ),
      };
    }
    return {};
  }

  void dispose() {
    _timer?.cancel(); // Cancelar o timer ao descartar o controller
  }
}
