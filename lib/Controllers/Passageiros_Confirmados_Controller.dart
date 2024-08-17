import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Models/passageiro.dart';

class PassageirosConfirmadosController {
  final List<Passageiro> passageiros;

  PassageirosConfirmadosController(this.passageiros);

  void showPontoDeInteresse(BuildContext context, Passageiro passageiro) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ponto de Interesse'),
          content: Container(
            height: 400,
            width: double.infinity,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  passageiro.pontoDeInteresse.latitude,
                  passageiro.pontoDeInteresse.longitude,
                ),
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('pontoDeInteresse'),
                  position: LatLng(
                    passageiro.pontoDeInteresse.latitude,
                    passageiro.pontoDeInteresse.longitude,
                  ),
                ),
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
