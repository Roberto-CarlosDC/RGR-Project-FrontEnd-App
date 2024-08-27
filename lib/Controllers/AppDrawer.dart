import 'package:flutter/material.dart';

import 'package:testergr/Models/passageiro.dart'; // remover, apenas aqui para testes
import 'package:testergr/Models/ponto_de_interesse.dart'; // remover, apenas aqui para testes

import '../Views/Meu_Perfil_Page.dart';
import '../Views/opcoes.dart';
import '../Views/Financeiro_page.dart';
import '../Views/pontosInteresse.dart';
import '../Views/Viagem.dart';
import '../Views/Local_Atual_Page.dart';
import '../Views/home.dart';
import '../Views/Passageiros_Confirmados_Page.dart';
import '../Views/Login.dart';
import '../Views/CadUsuario.dart';
import '../Views/DashBoard.dart';

// List<Passageiro> passageirosFicticios = [
//   Passageiro(
//     nome: 'João Silva',
//     passouPeloPonto: false,
//     pontoDeInteresse: PontoDeInteresse(
//       latitude: -23.5505,
//       longitude: -46.6333,
//     ),
//   ),
//   Passageiro(
//     nome: 'Maria Oliveira',
//     passouPeloPonto: true,
//     pontoDeInteresse: PontoDeInteresse(
//       latitude: -22.9068,
//       longitude: -43.1729,
//     ),
//   ),
//   Passageiro(
//     nome: 'Carlos Souza',
//     passouPeloPonto: false,
//     pontoDeInteresse: PontoDeInteresse(
//       latitude: -19.9167,
//       longitude: -43.9345,
//     ),
//   ),
//   Passageiro(
//     nome: 'Ana Lima',
//     passouPeloPonto: true,
//     pontoDeInteresse: PontoDeInteresse(
//       latitude: -15.7801,
//       longitude: -47.9292,
//     ),
//   ),
//   Passageiro(
//     nome: 'Pedro Santos',
//     passouPeloPonto: false,
//     pontoDeInteresse: PontoDeInteresse(
//       latitude: -12.9714,
//       longitude: -38.5014,
//     ),
//   ),
// ];



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transporte Universitário',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue[800], // Azul mais escuro
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.location_on,
            text: 'Localização Atual',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LocalizacaoAtualPage()),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.directions_bus,
            text: 'Viagens',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViagensPage()),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.place,
            text: 'Pontos de Interesse',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PontosInteressePage()),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.attach_money,
            text: 'Financeiro',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FinanceiroPage()),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.person,
            text: 'Meu Perfil',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MeuPerfilPage()),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            text: 'Opções',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OpcoesPage()),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            text: 'Login',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            text: 'Cadastro',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPage()),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            text: 'DashBoard',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmpresaSelectionPage()),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.list,
            text: 'Lista de Presença',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PassageirosConfirmadosPage(passageiros: [] ,)),
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(
      {required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]), // Cinza claro
      title: Text(text),
      onTap: onTap,
    );
  }
}