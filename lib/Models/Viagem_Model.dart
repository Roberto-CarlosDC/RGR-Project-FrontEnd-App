// lib/Models/viagem_model.dart

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
