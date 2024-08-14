import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testergr/rotaViagem.dart';
import 'teste.dart';

class ViagensPage extends StatefulWidget {
  @override
  _ViagensPageState createState() => _ViagensPageState();
}

class _ViagensPageState extends State<ViagensPage> {
  // Mock data for example purposes
  List<Viagem> viagens = [
    Viagem(
        periodo: '12:00 - 13:00',
        cidadeOrigem: 'Cidade A',
        cidadeDestino: 'Cidade B',
        tempoAcao: '1h',
        status: StatusViagem.emAberto),
    Viagem(
        periodo: '14:00 - 15:30',
        cidadeOrigem: 'Cidade C',
        cidadeDestino: 'Cidade D',
        tempoAcao: '1h 30m',
        status: StatusViagem.emAndamento),
    Viagem(
        periodo: '10:00 - 11:00',
        cidadeOrigem: 'Cidade E',
        cidadeDestino: 'Cidade F',
        tempoAcao: '1h',
        status: StatusViagem.terminada),
  ];

  Viagem? selectedViagem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Viagens'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: viagens.length,
        itemBuilder: (context, index) {
          final viagem = viagens[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedViagem = viagem;
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
      bottomNavigationBar: selectedViagem != null ? _buildBottomActionButtons() : SizedBox(),
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
              _showViagemDetails(selectedViagem!);
            },
            child: Text('Detalhes'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (selectedViagem!.presencaConfirmada) {
                  selectedViagem!.presencaConfirmada = false;
                } else {
                  selectedViagem!.presencaConfirmada = true;
                }
              });
            },
            child: Text(selectedViagem!.presencaConfirmada ? 'Retirar Presença' : 'Confirmar Presença'),
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
              // Placeholder for map and vehicle details
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

// Mock enum for travel status
enum StatusViagem { emAberto, emAndamento, terminada }

extension StatusViagemExtension on StatusViagem {
  String get label {
    switch (this) {
      case StatusViagem.emAberto:
        return 'Em Aberto';
      case StatusViagem.emAndamento:
        return 'Em Andamento';
      case StatusViagem.terminada:
        return 'Terminada';
      default:
        return '';
    }
  }
}

// Mock class for Viagem
class Viagem {
  final String periodo;
  final String cidadeOrigem;
  final String cidadeDestino;
  final String tempoAcao;
  final StatusViagem status;
  bool presencaConfirmada = false;

  Viagem({
    required this.periodo,
    required this.cidadeOrigem,
    required this.cidadeDestino,
    required this.tempoAcao,
    required this.status,
  });
}
