// lib/Controllers/viagem_controller.dart

import '../Models/Viagem_Model.dart';

class ViagemController {
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

  void selectViagem(Viagem viagem) {
    selectedViagem = viagem;
  }

  void togglePresencaConfirmada() {
    if (selectedViagem != null) {
      selectedViagem!.presencaConfirmada = !selectedViagem!.presencaConfirmada;
    }
  }
}
