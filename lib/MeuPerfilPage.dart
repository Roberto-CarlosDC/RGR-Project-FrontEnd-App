import 'package:flutter/material.dart';
import 'theme.dart'; // Importa o tema
import 'teste.dart'; // Importa o Menu Lateral

class MeuPerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
      ),
      drawer: AppDrawer(), // Menu Lateral
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_placeholder.png'), // Substitua pela imagem do perfil
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Nome do Cliente'),
              subtitle: Text('João da Silva'),
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('CPF'),
              subtitle: Text('123.456.789-00'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Número de Telefone'),
              subtitle: Text('(49) 99999-9999'),
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text('Cidade Vinculada'),
              subtitle: Text('Chapecó - SC'),
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
                // Adicione a lógica de redefinição de senha aqui
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
