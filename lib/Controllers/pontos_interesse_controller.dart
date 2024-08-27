import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/ponto_de_interesse.dart';

class PontosInteresseController {
  final String apiUrl = 'http://66.135.11.124:4200/inicio'; // URL da sua API

  // Método para buscar pontos de interesse com filtro
  Future<List<PontoDeInteresse>> buscarPontosDeInteresse(String filtro) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl?tipo=$filtro'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => PontoDeInteresse.fromJson(json)).toList();
      } else {
        throw Exception('Falha ao carregar os pontos de interesse');
      }
    } catch (e) {
      throw Exception('Erro ao conectar à API: $e');
    }
  }

  // Método para definir ponto de interesse como padrão
  Future<void> definirPontoComoPadrao({
    required String usuarioId,
    required String tipo,
    required int pontoId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/definirPadrao'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'usuarioId': usuarioId,
          'tipo': tipo,
          'pontoId': pontoId,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Falha ao definir o ponto como padrão');
      }
    } catch (e) {
      throw Exception('Erro ao conectar à API: $e');
    }
  }
}
