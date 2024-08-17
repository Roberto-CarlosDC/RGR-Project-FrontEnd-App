// lib/Models/trip_model.dart
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripModel {
  bool isTripActive;
  bool isUserConfirmed;
  LatLng? vehiclePosition;

  TripModel({
    required this.isTripActive,
    required this.isUserConfirmed,
    this.vehiclePosition,
  });
}
