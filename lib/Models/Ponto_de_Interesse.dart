class PontoDeInteresse {
  final int id;
  final String nome;
  final double latitude;
  final double longitude;

  PontoDeInteresse({
    required this.id,
    required this.nome,
    required this.latitude,
    required this.longitude,
  });

  factory PontoDeInteresse.fromJson(Map<String, dynamic> json) {
    return PontoDeInteresse(
      id: json['id'],
      nome: json['nome'],
      latitude: json['lat'],
      longitude: json['lng'],
    );
  }
}
