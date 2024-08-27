import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Controllers/AppDrawer.dart';
import '../Controllers/pontos_interesse_controller.dart';
import '../Models/ponto_de_interesse.dart';

class PontosInteressePage extends StatefulWidget {
  @override
  _PontosInteressePageState createState() => _PontosInteressePageState();
}

class _PontosInteressePageState extends State<PontosInteressePage> {
  String filtro = 'Embarque';
  Set<Marker> markers = {};
  GoogleMapController? mapController;
  final PontosInteresseController _controller = PontosInteresseController();

  @override
  void initState() {
    super.initState();
    _carregarPontos(filtro);
  }

  void _carregarPontos(String filtro) async {
    try {
      final pontos = await _controller.buscarPontosDeInteresse(filtro);
      setState(() {
        markers.clear();
        for (var ponto in pontos) {
          markers.add(
            Marker(
              markerId: MarkerId(ponto.id.toString()),
              position: LatLng(ponto.latitude, ponto.longitude),
              infoWindow: InfoWindow(title: ponto.nome),
              onTap: () {
                _showPontoSelecionado(ponto.id, ponto.nome, filtro);
              },
            ),
          );
        }
      });
    } catch (e) {
      // Lidar com o erro de conexão à API
      print('Erro ao carregar pontos: $e');
    }
  }

  void _showPontoSelecionado(int pontoId, String nomePonto, String filtro) {
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
                onPressed: () async {
                  try {
                    await _controller.definirPontoComoPadrao(
                      usuarioId: 'user123', // Substitua pelo ID real do usuário
                      tipo: filtro,
                      pontoId: pontoId,
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    // Lidar com erro de conexão à API
                    print('Erro ao definir ponto como padrão: $e');
                  }
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
                _carregarPontos(filtro); // Recarregar pontos ao mudar o filtro
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
                target: LatLng(-15.7942, -47.8822),
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
              items: markers.map<DropdownMenuItem<String>>((marker) {
                return DropdownMenuItem<String>(
                  value: marker.infoWindow.title,
                  child: Text(marker.infoWindow.title!),
                );
              }).toList(),
              onChanged: (String? newValue) {
                final markerSelecionado = markers
                    .firstWhere((marker) => marker.infoWindow.title == newValue);
                mapController?.animateCamera(
                  CameraUpdate.newLatLng(markerSelecionado.position),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
