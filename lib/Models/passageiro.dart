import 'ponto_de_interesse.dart';

class Passageiro {
  final String nome;
  final bool passouPeloPonto;
  final PontoDeInteresse pontoDeInteresse;

  Passageiro({
    required this.nome,
    required this.passouPeloPonto,
    required this.pontoDeInteresse,
  });
}
