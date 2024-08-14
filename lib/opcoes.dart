import 'package:flutter/material.dart';
import 'theme.dart'; // Importe o tema
import 'teste.dart';
//import './MeuPerfilPage.dart';

class OpcoesPage extends StatefulWidget {
  @override
  _OpcoesPageState createState() => _OpcoesPageState();
}

class _OpcoesPageState extends State<OpcoesPage> {
  bool isDarkMode = false;

  void _toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      theme: isDarkMode ? ThemeData.dark() : AppTheme.themeData,
      home: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Opções'),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Dados da Conta'),
              onTap: () {
                _showDadosContaModal(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.business),
              title: Text('Dados da Empresa Vinculada'),
              onTap: () {
                _showDadosEmpresaModal(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Sobre'),
              onTap: () {
                _showSobreModal(context);
              },
            ),
            SwitchListTile(
              title: Text('Modo Noturno'),
              value: isDarkMode,
              onChanged: (value) {
                _toggleDarkMode();
              },
              secondary: Icon(Icons.nightlight_round),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              onTap: () {
                _logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDadosContaModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dados da Conta'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Nome Completo: João da Silva'),
              Text('CPF: 123.456.789-00'),
              Text('Telefone: (49) 99999-9999'),
              Text('Data de Criação da Conta: 01/01/2020'),
              Text('Data de Nascimento: 01/01/2000'),
              Text('Idade: 24 anos'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDadosEmpresaModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dados da Empresa Vinculada'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Nome da Empresa: Transporte Universitário Ltda.'),
              Text('CNPJ: 12.345.678/0001-00'),
              Text('Cidade de Atuação: Chapecó - SC'),
              Text('Contato: (49) 88888-8888'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSobreModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sobre'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Aplicativo de Gestão de Transporte Universitário.'),
              Text('Versão: 1.0.0'),
              Text('Desenvolvido para facilitar o transporte coletivo de estudantes universitários.'),
              Text('Funcionalidades:'),
              Text('- Gerenciamento de rotas.'),
              Text('- Pontos de Embarque e Desembarque.'),
              Text('- Listas de Presença.'),
              Text('- Visualização de viagens.'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    // Lógica de logout aqui
    Navigator.of(context).popUntil((route) => route.isFirst); // Retorna à tela de login
  }
}



//-*-*-*-*-*-*-*-*


