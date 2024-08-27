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

// lib/Models/Viagem_Model.dart

class Viagem {
  String periodo;
  String cidadeOrigem;
  String cidadeDestino;
  String tempoAcao;
  StatusViagem status;
  bool presencaConfirmada;
  String? selectedRetornoOption; // Novo campo para armazenar a opção de retorno selecionada

  Viagem({
    required this.periodo,
    required this.cidadeOrigem,
    required this.cidadeDestino,
    required this.tempoAcao,
    required this.status,
    this.presencaConfirmada = false,
    this.selectedRetornoOption,
  });
}

