import 'package:flutter/material.dart';
import '../Models/passageiro.dart';
import '../Controllers/Passageiros_Confirmados_Controller.dart';
import 'Passageiros_Card.dart';
import '../Controllers/AppDrawer.dart';

class PassageirosConfirmadosPage extends StatelessWidget {
  final PassageirosConfirmadosController controller;

  PassageirosConfirmadosPage({required List<Passageiro> passageiros})
      : controller = PassageirosConfirmadosController(passageiros);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passageiros Confirmados'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: controller.passageiros.length,
        itemBuilder: (context, index) {
          final passageiro = controller.passageiros[index];
          return PassageiroCard(
            passageiro: passageiro,
            index: index,
            onTap: () {
              controller.showPontoDeInteresse(context, passageiro);
            },
          );
        },
      ),
    );
  }
}
