// lib/Controllers/trip_controller.dart
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../Models/Trip_Model.dart';

class TripController {
  final TripModel tripModel;
  GoogleMapController? mapController;
  Location _location = Location();

  TripController({required this.tripModel});

  void init() {
    _location.onLocationChanged.listen((LocationData currentLocation) {
      if (tripModel.isTripActive && tripModel.isUserConfirmed) {
        updateVehicleLocation(
          LatLng(currentLocation.latitude!, currentLocation.longitude!),
        );
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
}
