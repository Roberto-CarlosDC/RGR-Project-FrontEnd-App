import 'package:flutter/material.dart';
import 'theme.dart'; // Importe o tema
import './teste.dart';
import 'home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transporte Universitário',
      theme: AppTheme.themeData, // Aplique o tema aqui
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

// class LocalizacaoAtualPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Localização Atual'),
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
