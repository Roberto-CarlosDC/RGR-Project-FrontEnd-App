// lib/Components/viagem_card.dart

import 'package:flutter/material.dart';
import '../Models/Viagem_Model.dart';

class ViagemCard extends StatelessWidget {
  final Viagem viagem;
  final VoidCallback? onTap;

  ViagemCard({required this.viagem, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  style: TextStyle(
                    color: viagem.status == StatusViagem.emAndamento
                        ? Colors.orange
                        : Colors.green,
                  ),
                ),
        ),
      ),
    );
  }
}
