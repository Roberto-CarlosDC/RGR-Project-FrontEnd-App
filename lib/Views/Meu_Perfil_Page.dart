// lib/Views/meu_perfil_page.dart

import 'package:flutter/material.dart';
import '../Controllers/AppDrawer.dart';
import '../Controllers/meu_perfil_controller.dart';

class MeuPerfilPage extends StatelessWidget {
  final MeuPerfilController _controller = MeuPerfilController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(_controller.usuario.imagemPerfil),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Nome do Cliente'),
              subtitle: Text(_controller.usuario.nome),
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('CPF'),
              subtitle: Text(_controller.usuario.cpf),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Número de Telefone'),
              subtitle: Text(_controller.usuario.telefone),
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text('Cidade Vinculada'),
              subtitle: Text(_controller.usuario.cidade),
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Trocar Senha'),
              onTap: () {
                _showTrocaSenhaModal(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTrocaSenhaModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Trocar Senha'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha Atual',
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Nova Senha',
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmar Nova Senha',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Redefinir Senha'),
              onPressed: () {
                // Substitua pelos valores reais dos TextFields
                _controller.trocarSenha('senhaAtual', 'novaSenha', 'confirmarNovaSenha');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
