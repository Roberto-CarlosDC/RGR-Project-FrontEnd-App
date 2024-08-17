// lib/Controllers/meu_perfil_controller.dart

import '../Models/usuario.dart';

class MeuPerfilController {
  final Usuario usuario = Usuario(
    nome: 'João da Silva',
    cpf: '123.456.789-00',
    telefone: '(49) 99999-9999',
    cidade: 'Chapecó - SC',
    imagemPerfil: 'assets/profile_placeholder.png',
  );

  // Método para redefinir a senha
  void trocarSenha(String senhaAtual, String novaSenha, String confirmarNovaSenha) {
    // Adicione a lógica de redefinição de senha aqui
  }
}
