// lib/Views/localizacao_atual_page.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Controllers/Local_Atual_Controller.dart';
import '../Models/Trip_Model.dart';
import '../Controllers/AppDrawer.dart';

class LocalizacaoAtualPage extends StatefulWidget {
  @override
  _LocalizacaoAtualPageState createState() => _LocalizacaoAtualPageState();
}

class _LocalizacaoAtualPageState extends State<LocalizacaoAtualPage> {
  late TripController _tripController;

  @override
  void initState() {
    super.initState();
    TripModel tripModel = TripModel(isTripActive: true, isUserConfirmed: true);
    _tripController = TripController(tripModel: tripModel);
    _tripController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Localização Atual'),
      ),
      drawer: AppDrawer(),
      body: _tripController.tripModel.isTripActive &&
              _tripController.tripModel.isUserConfirmed
          ? Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      _tripController.mapController = controller;
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(-15.7942, -47.8822), // Coordenadas iniciais (exemplo)
                      zoom: 14,
                    ),
                    markers: _tripController.getVehicleMarker(),
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
