import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'teste.dart';

class LocalizacaoAtualPage extends StatefulWidget {
  @override
  _LocalizacaoAtualPageState createState() => _LocalizacaoAtualPageState();
}

class _LocalizacaoAtualPageState extends State<LocalizacaoAtualPage> {
  GoogleMapController? _mapController;
  Location _location = Location();
  Marker? _vehicleMarker;
  bool _isTripActive = true;  // Mocked value, you should replace this with actual logic
  bool _isUserConfirmed = true;  // Mocked value, you should replace this with actual logic

  @override
  void initState() {
    super.initState();
    _location.onLocationChanged.listen((LocationData currentLocation) {
      if (_isTripActive && _isUserConfirmed) {
        _updateVehicleLocation(
          LatLng(currentLocation.latitude!, currentLocation.longitude!),
        );
      }
    });
  }

  void _updateVehicleLocation(LatLng vehiclePosition) {
    setState(() {
      _vehicleMarker = Marker(
        markerId: MarkerId('vehicle_marker'),
        position: vehiclePosition,
        infoWindow: InfoWindow(title: "Veículo Atual"),
      );
    });

    _mapController?.animateCamera(
      CameraUpdate.newLatLng(vehiclePosition),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Localização Atual'),
      ),
      drawer: AppDrawer(),
      body: _isTripActive && _isUserConfirmed
          ? Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(-15.7942, -47.8822), // Coordenadas iniciais (exemplo)
                      zoom: 14,
                    ),
                    markers: _vehicleMarker != null ? {_vehicleMarker!} : {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informações da Viagem Ativa:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('Período: 12:00 - 13:00'),
                      Text('Cidade de Origem: Cidade X'),
                      Text('Cidade de Destino: Cidade Y'),
                      Text('Tempo de Ação: 1h'),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                'Nenhuma viagem ativa ou presença não confirmada.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
