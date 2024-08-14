import 'package:flutter/material.dart';
import 'MeuPerfilPage.dart';
import 'opcoes.dart';
import 'financeiro.dart';
import 'pontosInteresse.dart';
import 'viagens.dart';
import 'locAtual.dart';
import 'home.dart';


void main() {
  runApp(MyApp());
}

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

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Transporte Universitário'),
//         backgroundColor: Colors.blue[800], // Azul mais escuro
//       ),
//       drawer: AppDrawer(),
//       body: Center(
//         child: Text(
//           'Home - Síntese das Informações',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

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

// class LocalizacaoAtualPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Localização Atual'),
//         backgroundColor: Colors.blue[800],
//       ),
//       body: Center(
//         child: Text(
//           'Localização Atual',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

// class ViagensPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Viagens'),
//         backgroundColor: Colors.blue[800],
//       ),
//       body: Center(
//         child: Text(
//           'Viagens',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

// class PontosInteressePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pontos de Interesse'),
//         backgroundColor: Colors.blue[800],
//       ),
//       body: Center(
//         child: Text(
//           'Pontos de Interesse (Embarque e Desembarque)',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

// class FinanceiroPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Financeiro'),
//         backgroundColor: Colors.blue[800],
//       ),
//       body: Center(
//         child: Text(
//           'Financeiro',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

// class MeuPerfilPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Meu Perfil'),
//         backgroundColor: Colors.blue[800],
//       ),
//       body: Center(
//         child: Text(
//           'Meu Perfil',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

// class OpcoesPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Opções'),
//         backgroundColor: Colors.blue[800],
//       ),
//       body: Center(
//         child: Text(
//           'Opções',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }
