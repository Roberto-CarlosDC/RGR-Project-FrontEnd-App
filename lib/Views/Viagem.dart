// lib/Views/viagens_page.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testergr/Models/Viagem_Model.dart';
import 'package:testergr/Views/rotaViagem.dart';
import '../Controllers/Viagem_Controller.dart';
import '../Controllers/AppDrawer.dart';
import '../Models/Viagem_Card.dart';


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
          return ViagemCard(
            viagem: viagem,
            onTap: () {
              setState(() {
                _viagemController.selectViagem(viagem);
              });
            },
          );
        },
      ),
      bottomNavigationBar: _viagemController.selectedViagem != null
          ? _buildBottomActionButtons()
          : SizedBox(),
    );
  }

  Widget _buildBottomActionButtons() {
    final viagem = _viagemController.selectedViagem!;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              _showViagemDetails(viagem);
            },
            child: Text('Detalhes'),
          ),
          ElevatedButton(
            onPressed: () {
              if (!viagem.presencaConfirmada) {
                _showRetornoOptions(context, viagem);
              } else {
                setState(() {
                  _viagemController.togglePresencaConfirmada();
                });
              }
            },
            child: Text(
              viagem.presencaConfirmada ? 'Retirar Presença' : 'Confirmar Presença',
            ),
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

  void _showRetornoOptions(BuildContext context, Viagem viagem) {
    showDialog(
      context: context,
      barrierDismissible: false, // Impede fechar ao clicar fora
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Selecione a Opção de Retorno"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: Text("Sem Retorno"),
                    value: "Sem Retorno",
                    groupValue: viagem.selectedRetornoOption,
                    onChanged: (value) {
                      setDialogState(() {
                        viagem.selectedRetornoOption = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text("Apenas Retorno"),
                    value: "Apenas Retorno",
                    groupValue: viagem.selectedRetornoOption,
                    onChanged: (value) {
                      setDialogState(() {
                        viagem.selectedRetornoOption = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text("Retorno no Período da Manhã"),
                    value: "Retorno no Período da Manhã",
                    groupValue: viagem.selectedRetornoOption,
                    onChanged: (value) {
                      setDialogState(() {
                        viagem.selectedRetornoOption = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text("Retorno no Período da Tarde"),
                    value: "Retorno no Período da Tarde",
                    groupValue: viagem.selectedRetornoOption,
                    onChanged: (value) {
                      setDialogState(() {
                        viagem.selectedRetornoOption = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text("Retorno no Período da Noite"),
                    value: "Retorno no Período da Noite",
                    groupValue: viagem.selectedRetornoOption,
                    onChanged: (value) {
                      setDialogState(() {
                        viagem.selectedRetornoOption = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      viagem.presencaConfirmada = true;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Confirmar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
