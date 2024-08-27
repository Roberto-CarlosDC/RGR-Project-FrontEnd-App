import 'package:flutter/material.dart';
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
  String? selectedRetornoOption;

  void selectViagem(Viagem viagem) {
    selectedViagem = viagem;
  }

  void togglePresencaConfirmada() {
    if (selectedViagem != null) {
      selectedViagem!.presencaConfirmada = !selectedViagem!.presencaConfirmada;
    }
  }

  void setRetornoOption(String? option) {
    selectedRetornoOption = option;
  }
}

void showRetornoOptions(BuildContext context, ViagemController viagemController) {
  showDialog(
    context: context,
    barrierDismissible: false, // O modal não pode ser fechado ao clicar fora dele
    builder: (BuildContext context) {
      String? selectedOption = viagemController.selectedRetornoOption;

      return AlertDialog(
        title: Text("Selecione a Opção de Retorno"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: Text("Sem Retorno"),
              value: "Sem Retorno",
              groupValue: selectedOption,
              onChanged: (value) {
                viagemController.setRetornoOption(value);
                selectedOption = value;
              },
            ),
            RadioListTile<String>(
              title: Text("Apenas Retorno"),
              value: "Apenas Retorno",
              groupValue: selectedOption,
              onChanged: (value) {
                viagemController.setRetornoOption(value);
                selectedOption = value;
              },
            ),
            RadioListTile<String>(
              title: Text("Retorno no Período da Manhã"),
              value: "Retorno no Período da Manhã",
              groupValue: selectedOption,
              onChanged: (value) {
                viagemController.setRetornoOption(value);
                selectedOption = value;
              },
            ),
            RadioListTile<String>(
              title: Text("Retorno no Período da Tarde"),
              value: "Retorno no Período da Tarde",
              groupValue: selectedOption,
              onChanged: (value) {
                viagemController.setRetornoOption(value);
                selectedOption = value;
              },
            ),
            RadioListTile<String>(
              title: Text("Retorno no Período da Noite"),
              value: "Retorno no Período da Noite",
              groupValue: selectedOption,
              onChanged: (value) {
                viagemController.setRetornoOption(value);
                selectedOption = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Cancela a presença se o usuário clicar em "Cancelar"
              viagemController.selectedViagem?.presencaConfirmada = false;
              Navigator.of(context).pop(); // Fecha o modal
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Apenas confirma a presença se o usuário clicar em "Confirmar"
              if (selectedOption != null) {
                viagemController.setRetornoOption(selectedOption);
                Navigator.of(context).pop(); // Fecha o modal
              }
            },
            child: Text('Confirmar'),
          ),
        ],
      );
    },
  );
}
