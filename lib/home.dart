import 'package:flutter/material.dart';
import 'theme.dart'; // Importa o tema
import 'viagens.dart'; // Importa a classe Viagem (que define o card de viagem)
import 'financeiro.dart'; // Importa a classe Financeiro (que define o card financeiro)
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Importa o Google Maps
import 'teste.dart';

class HomePage extends StatelessWidget {
  final Viagem proximaViagem = Viagem(
    periodo: "12:00 - 13:00",
    cidadeOrigem: "Chapecó",
    cidadeDestino: "Florianópolis",
    tempoAcao: "1h", 
    status: StatusViagem.emAndamento,
    // Outros detalhes necessários
  );

  final bool hasPendingPayments = true; // Verifica se há boletos pendentes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transporte Universitário - Home'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Primeira metade - Próxima viagem
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ViagemCard(
                viagem: proximaViagem,
                onPresencaConfirmada: (isConfirmed) {
                  // Implementa a lógica de confirmação de presença
                },
                mostrarBotaoPresenca: true, // Exibe o botão de presença dentro do card
                mostrarMapa: true, // Exibe o mapa no modal de detalhes
              ),
            ),
            // Segunda metade - Informações financeiras
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: hasPendingPayments ? FinanceiroCard(
                titulo: "Boleto de Mensalidade",
                dataVencimento: "10/08/2024",
                onDownload: () {
                  // Implementa a lógica de download do boleto
                },
              ) : Center(
                child: Text(
                  'Sem Questões de Pagamento Pendentes',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViagemCard extends StatelessWidget {
  final Viagem viagem;
  final Function(bool) onPresencaConfirmada;
  final bool mostrarBotaoPresenca;
  final bool mostrarMapa;

  ViagemCard({
    required this.viagem,
    required this.onPresencaConfirmada,
    this.mostrarBotaoPresenca = false,
    this.mostrarMapa = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(viagem.periodo, style: TextStyle(fontSize: 18)),
            Text(viagem.cidadeOrigem + " -> " + viagem.cidadeDestino),
            Text("Tempo de Ação: " + viagem.tempoAcao),
            if (mostrarBotaoPresenca)
              ElevatedButton(
                onPressed: () {
                  onPresencaConfirmada(true);
                },
                child: Text("Confirmar Presença"),
              ),
            if (mostrarMapa)
              ElevatedButton(
                onPressed: () {
                  // Lógica para abrir o modal de detalhes com o mapa
                },
                child: Text("Detalhes"),
              ),
          ],
        ),
      ),
    );
  }
}

class FinanceiroCard extends StatelessWidget {
  final String titulo;
  final String dataVencimento;
  final Function onDownload;

  FinanceiroCard({
    required this.titulo,
    required this.dataVencimento,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo, style: TextStyle(fontSize: 18)),
                Text("Vencimento: " + dataVencimento),
              ],
            ),
            IconButton(
              icon: Icon(Icons.download),
              onPressed: () {
                onDownload();
              },
            ),
          ],
        ),
      ),
    );
  }
}
