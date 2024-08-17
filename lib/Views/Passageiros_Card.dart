import 'package:flutter/material.dart';
import '../Models/passageiro.dart';

class PassageiroCard extends StatelessWidget {
  final Passageiro passageiro;
  final int index;
  final VoidCallback onTap;

  PassageiroCard({
    required this.passageiro,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: passageiro.passouPeloPonto ? Colors.green[100] : Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          child: Text((index + 1).toString()), // Numeração
        ),
        title: Text(passageiro.nome),
        trailing: IconButton(
          icon: Icon(Icons.location_on),
          onPressed: onTap,
        ),
      ),
    );
  }
}
