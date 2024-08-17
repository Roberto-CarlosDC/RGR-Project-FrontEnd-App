// lib/Views/viagens_page.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Controllers/viagem_controller.dart';
import '../Models/Viagem_Model.dart';
import '../Controllers/AppDrawer.dart';
import 'rotaViagem.dart';

class ViagensPage extends StatefulWidget {
  @override
  _ViagensPageState createState() => _ViagensPageState();
}

class _ViagensPageState extends State<ViagensPage> {
  final ViagemController _viagemController = ViagemController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Viagens'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: _viagemController.viagens.length,
        itemBuilder: (context, index) {
          final viagem = _viagemController.viagens[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _viagemController.selectViagem(viagem);
              });
            },
            child: Card(
              color: viagem.status == StatusViagem.terminada
                  ? Colors.grey[300]
                  : Colors.white,
              child: ListTile(
                title: Text('${viagem.periodo} - ${viagem.cidadeOrigem} > ${viagem.cidadeDestino}'),
                subtitle: Text('${viagem.tempoAcao} | Status: ${viagem.status.label}'),
                trailing: viagem.status == StatusViagem.terminada
                    ? Text(
                        'Terminada',
                        style: TextStyle(color: Colors.red),
                      )
                    : Text(
                        viagem.status.label,
                        style: TextStyle(color: viagem.status == StatusViagem.emAndamento ? Colors.orange : Colors.green),
                      ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _viagemController.selectedViagem != null
          ? _buildBottomActionButtons()
          : SizedBox(),
    );
  }

  Widget _buildBottomActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              _showViagemDetails(_viagemController.selectedViagem!);
            },
            child: Text('Detalhes'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _viagemController.togglePresencaConfirmada();
              });
            },
            child: Text(_viagemController.selectedViagem!.presencaConfirmada
                ? 'Retirar Presença'
                : 'Confirmar Presença'),
          ),
        ],
      ),
    );
  }

  void _showViagemDetails(Viagem viagem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detalhes da Viagem',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('Período: ${viagem.periodo}'),
              Text('Origem: ${viagem.cidadeOrigem}'),
              Text('Destino: ${viagem.cidadeDestino}'),
              Text('Tempo de Ação: ${viagem.tempoAcao}'),
              SizedBox(height: 16),
              Container(
                height: 200,
                color: Colors.blueGrey[100],
                child: ViagemDetailsMap(
                  origem: LatLng(-23.550520, -46.633308), // Exemplo de coordenadas
                  destino: LatLng(-22.908333, -43.196388),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.directions_bus, size: 30),
                  SizedBox(width: 8),
                  Text('Veículo Confirmado: Ônibus'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
