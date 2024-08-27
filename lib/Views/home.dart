import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testergr/Models/Weekly_Calendar.dart';
import 'package:testergr/Views/rotaViagem.dart';
import '../Controllers/viagem_controller.dart';
import '../Models/Viagem_Model.dart';
import '../Models/Viagem_Card.dart';
import '../Controllers/AppDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ViagemController _viagemController = ViagemController();
  Viagem? _proximaViagem;
  final DateTime _currentDate = DateTime.now();

  final Set<DateTime> _holidays = {
    DateTime(2024, 8, 23), // Exemplo de feriado
    DateTime(2024, 8, 28), // Exemplo de dia sem viagem
  }; // Adicione feriados reais aqui

  final Map<DateTime, String> _noTravelReasons = {
    DateTime(2024, 8, 23): 'Feriado Nacional',
    DateTime(2024, 8, 28): 'Sem Viagens Programadas',
  }; // Adicione razões reais aqui

  @override
  void initState() {
    super.initState();
    _buscarProximaViagem();
  }

  void _buscarProximaViagem() {
    final now = DateTime.now();

    final viagensFiltradas = _viagemController.viagens
        .where((viagem) => viagem.status != StatusViagem.terminada)
        .map((viagem) {
      final horarios = viagem.periodo.split(' - ');
      final horaInicio = _parseHorario(horarios[0]);
      final horaFim = _parseHorario(horarios[1]);

      if (now.isBefore(horaInicio)) {
        viagem.status = StatusViagem.emAberto;
      } else if (now.isAfter(horaInicio) && now.isBefore(horaFim)) {
        viagem.status = StatusViagem.emAndamento;
      }

      return viagem;
    }).toList();

    if (viagensFiltradas.isNotEmpty) {
      _proximaViagem = viagensFiltradas.reduce((a, b) =>
          _parseHorario(a.periodo.split(' - ')[0])
              .isBefore(_parseHorario(b.periodo.split(' - ')[0]))
              ? a
              : b);
    } else {
      _proximaViagem = null; // Caso não haja viagens válidas
    }
  }

  DateTime _parseHorario(String horario) {
    final partes = horario.split(':');
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(partes[0]),
      int.parse(partes[1]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final proximaViagem = _proximaViagem;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Seção 1: Viagens Confirmadas
              Text(
                'Viagens Confirmadas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              if (proximaViagem != null)
                ViagemCard(
                  viagem: proximaViagem,
                  onTap: () {
                    setState(() {
                      _viagemController.selectViagem(proximaViagem);
                    });
                  },
                ),
              SizedBox(height: 16),
              Container(
                height: 250,
                child: WeeklyCalendar(
                  currentDate: _currentDate,
                  holidays: _holidays,
                  noTravelReasons: _noTravelReasons,
                ),
              ),
              SizedBox(height: 32), // Espaço entre seções
              // Seção 2: Informações Financeiras
              Text(
                'Informações Financeiras',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              // Deixe essa parte em branco por enquanto
              Container(
                height: 100,
                color: Colors.grey[200],
                alignment: Alignment.center,
                child: Text('Seção Financeira (Em branco)'),
              ),
            ],
          ),
        ),
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
            child: Text(
                _viagemController.selectedViagem!.presencaConfirmada
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
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
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
