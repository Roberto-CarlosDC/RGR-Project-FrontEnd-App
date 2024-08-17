import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Controllers/AppDrawer.dart';

class PontosInteressePage extends StatefulWidget {
  @override
  _PontosInteressePageState createState() => _PontosInteressePageState();
}

class _PontosInteressePageState extends State<PontosInteressePage> {
  String filtro = 'Embarque';
  Set<Marker> markers = {};
  GoogleMapController? mapController;

  // Exemplo de dados estáticos para os pontos
  final List<Map<String, dynamic>> pontos = [
    {"id": 1, "nome": "Ponto 1", "lat": -15.7942, "lng": -47.8822},
    {"id": 2, "nome": "Ponto 2", "lat": -15.7935, "lng": -47.8818},
  ];

  @override
  void initState() {
    super.initState();
    _carregarPontos();
  }

  void _carregarPontos() {
    setState(() {
      markers.clear();
      for (var ponto in pontos) {
        markers.add(
          Marker(
            markerId: MarkerId(ponto['id'].toString()),
            position: LatLng(ponto['lat'], ponto['lng']),
            infoWindow: InfoWindow(title: ponto['nome']),
            onTap: () {
              // Ação ao tocar no ponto
              _showPontoSelecionado(ponto['nome']);
            },
          ),
        );
      }
    });
  }

  void _showPontoSelecionado(String nomePonto) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Ponto Selecionado: $nomePonto'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implementar lógica para definir como padrão
                  Navigator.pop(context);
                },
                child: Text('DEFINIR COMO PADRÃO'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('CANCELAR'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pontos de Interesse'),
        actions: [
          DropdownButton<String>(
            value: filtro,
            icon: Icon(Icons.filter_list, color: Colors.white),
            onChanged: (String? newValue) {
              setState(() {
                filtro = newValue!;
                // Implementar lógica de filtro aqui
              });
            },
            items: <String>['Embarque', 'Desembarque']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(-15.7942, -47.8822), // Posição inicial no mapa
                zoom: 15,
              ),
              markers: markers,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Selecionar Ponto',
                border: OutlineInputBorder(),
              ),
              items: pontos.map<DropdownMenuItem<String>>((ponto) {
                return DropdownMenuItem<String>(
                  value: ponto['nome'],
                  child: Text(ponto['nome']),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Implementar lógica para centralizar o mapa no ponto selecionado
                final pontoSelecionado = pontos
                    .firstWhere((ponto) => ponto['nome'] == newValue);
                mapController?.animateCamera(
                  CameraUpdate.newLatLng(
                    LatLng(pontoSelecionado['lat'], pontoSelecionado['lng']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
